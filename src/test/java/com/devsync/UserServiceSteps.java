import com.devsync.dao.UserDao;
import com.devsync.domain.entities.User;
import com.devsync.domain.enums.UserType;
import com.devsync.service.UserService;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.cucumber.java.Before;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class UserServiceSteps {

    @Mock
    private UserDao userDao;

    @InjectMocks
    private UserService userService;

    private List<User> users;
    private User user;

    @Before
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Given("the system has users")
    public void systemHasUsers() {
        users = new ArrayList<>();
        users.add(new User(1L, "User", "One", "user1@example.com", "password", "user1", UserType.USER, 1, 1));
        when(userDao.findAll()).thenReturn(users);
    }

    @When("I retrieve all users")
    public void retrieveAllUsers() {
        users = userService.findAll();
    }

    @Then("I should get a list of users with size {int}")
    public void shouldGetListOfUsersWithSize(int size) {
        assertEquals(size, users.size());
        verify(userDao, times(1)).findAll();
    }

    @Given("I have a new user")
    public void iHaveANewUser() {
        user = new User(1L, "User", "Two", "user2@example.com", "password", "user2", UserType.USER, 1, 1);
        when(userDao.save(user)).thenReturn(user);
    }

    @When("I save the user")
    public void saveUser() {
        user = userService.save(user);
    }

    @Then("the user should be saved and returned")
    public void userShouldBeSavedAndReturned() {
        assertEquals("user2", user.getUsername());
        verify(userDao, times(1)).save(user);
    }

    @Given("the system has a user with id {long}")
    public void systemHasUserWithId(Long id) {
        User mockUser = new User(id, "User", "Three", "user3@example.com", "password", "user3", UserType.USER, 1, 2);
        when(userDao.findById(id)).thenReturn(mockUser);
    }

    @When("I search for the user by id")
    public void searchForUserById() {
        user = userService.findById(1L);
    }

    @Then("I should get the user with username {string}")
    public void shouldGetUserWithUsername(String username) {
        assertEquals(username, user.getUsername());
        verify(userDao, times(1)).findById(1L);
    }

    @When("I delete the user")
    public void deleteUser() {
        userService.delete(1L);
    }

    @Then("the user should be removed from the system")
    public void userShouldBeRemovedFromSystem() {
        verify(userDao, times(1)).delete(1L);
    }
}
