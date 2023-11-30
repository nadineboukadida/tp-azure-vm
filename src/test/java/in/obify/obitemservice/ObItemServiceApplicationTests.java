package in.obify.obitemservice;

import in.obify.obitemservice.controller.ItemCategoryController;
import in.obify.obitemservice.model.ItemCategoryModel;
import in.obify.obitemservice.repository.ItemCategoryRepository;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

@SpringBootTest
class ItemCategoryControllerTest {

    @InjectMocks
    private ItemCategoryController itemCategoryController;

    @Mock
    private ItemCategoryRepository itemCategoryRepository;

    @Test
    void getAllItemCategory() {
        // Given
        ItemCategoryModel category1 = new ItemCategoryModel("1", "Category 1");
        ItemCategoryModel category2 = new ItemCategoryModel("2", "Category 2");

        List<ItemCategoryModel> categories = Arrays.asList(category1, category2);

        when(itemCategoryRepository.findAll()).thenReturn(categories);

        // When
        List<ItemCategoryModel> result = itemCategoryController.getAllItemCategory();

        // Then
        assertEquals(categories, result);
    }
}
