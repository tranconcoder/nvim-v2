/**
 * Helpers for building consistent S3 object keys used across the application.
 */
export const productCategoryImageKey = (
  categoryId: string | number,
  extension?: string,
): string => {
  const id = typeof categoryId === 'number' ? String(categoryId) : categoryId;
  return extension && extension ~= ''
    ? `product-category/images/${id}.${extension}`
    : `product-category/images/${id}`;
};
