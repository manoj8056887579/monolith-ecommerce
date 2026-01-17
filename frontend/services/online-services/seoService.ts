import axiosInstance from "@/lib/axios";

export interface PageSEO {
  id: string | null;
  pagePath: string;
  pageName: string;
  description: string | null;
  metaTitle: string;
  metaDescription: string;
  metaKeywords: string;
  ogImage: string | null;
  isActive: boolean;
}

// Get SEO data for a specific page
export const getPageSEO = async (pagePath: string): Promise<PageSEO | null> => {
  try {
    // Skip API call during build time (when backend is not running)
    if (process.env.NODE_ENV === 'production' && typeof window === 'undefined') {
      console.log(`Skipping SEO fetch during build for: ${pagePath}`);
      return null;
    }

    const encodedPath = encodeURIComponent(pagePath);
    const response = await axiosInstance.get(`/api/web/seo/page/${encodedPath}`);
    
    if (response.data.success) {
      return response.data.data;
    }
    return null;
  } catch (error) {
    // Silently fail during build time
    if (typeof window === 'undefined') {
      console.log(`SEO data not available for ${pagePath} (backend not running)`);
      return null;
    }
    console.error("Error fetching page SEO:", error);
    return null;
  }
};

// Get all page SEO data
export const getAllPageSEO = async (): Promise<PageSEO[]> => {
  try {
    // Skip API call during build time
    if (process.env.NODE_ENV === 'production' && typeof window === 'undefined') {
      console.log('Skipping SEO fetch during build');
      return [];
    }

    const response = await axiosInstance.get("/api/web/seo");
    
    if (response.data.success) {
      return response.data.data;
    }
    return [];
  } catch (error) {
    // Silently fail during build time
    if (typeof window === 'undefined') {
      console.log('SEO data not available (backend not running)');
      return [];
    }
    console.error("Error fetching all page SEO:", error);
    return [];
  }
};
