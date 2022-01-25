# Godot | AppFactory 3.X | 4.x
Creation of GUI and modules for multiplatform applications. Graphic design and 3D modeling.

**How does it work**
Only copy the directory (app_core) if you want to use all the app modules, otherwise choose one in the (app_core) folder and paste it in your project directory.

You can clone this repository and open it directly with Godot and you will be able to review each node of the project.

**-- APP_CORE --**

**GLOBALS**

|   |               |                                                          |                                                                    |                  |
| - | ------------- | -------------------------------------------------------- | ------------------------------------------------------------------ | ---------------- |
|   | **Global**    | **Dependency**                                           | **Description**                                                    | **Demostration** |
| 1 | FuncApp       | /gloabals/ func\_app.tscn                              | Setting of App, colors, stytle, size, global vars                  | video            |
| 2 | Messages      | /gloabals/ messages.gd                                 | Translate tags a text of App                                       |                  |
| 3 | SliderControl | /gloabals/ slider.gd                                   | Tools and vars for input system                                    |                  |
| 4 | DbQuery       | /gloabals/ <span class="underline">DB\_query.gd</span> | SQL alternative                                                    |                  |
| 5 | Loading       | /gloabals/ loading.gd                                  | Scene change, background loading, navigation history on back click |                  |

**MODULES | NODE**

<table>
<tbody>
<tr class="odd">
<td></td>
<td><strong>Module</strong></td>
<td><strong>Dependency</strong></td>
<td><strong>Description</strong></td>
<td><strong>Demostration</strong></td>
</tr>
<tr class="even">
<td>1</td>
<td>awesome_button</td>
<td>addons/FontAwesome</td>
<td></td>
<td>video</td>
</tr>
<tr class="odd">
<td>2</td>
<td>dynamic_button</td>
<td></td>
<td>Node Button, style and true type font</td>
<td></td>
</tr>
<tr class="even">
<td>3</td>
<td>dynamic_label</td>
<td></td>
<td>General configuration, auto adjust and true type font</td>
<td></td>
</tr>
<tr class="odd">
<td>4</td>
<td>panel_round</td>
<td></td>
<td>Node Panel, style dynamic</td>
<td></td>
</tr>
<tr class="even">
<td>5</td>
<td>slider_gallery</td>
<td></td>
<td>Beatiful responsive slider page</td>
<td></td>
</tr>
<tr class="odd">
<td>6</td>
<td>slider_side_menu</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr class="even">
<td>7</td>
<td>topBar</td>
<td><p>1- awesome_button</p>
<p>4- panel_round</p></td>
<td>Node CanvasLayer</td>
<td></td>
</tr>
<tr class="odd">
<td>8</td>
<td>viewer</td>
<td>style</td>
<td>Node VBoxContainer Scroll list, a pagination system</td>
<td></td>
</tr>
<tr class="even">
<td>9</td>
<td>camera</td>
<td></td>
<td>Transitions effect system</td>
<td></td>
</tr>
<tr class="odd">
<td>10</td>
<td>DB_create</td>
<td></td>
<td>Convert .csv/.txt to DB.cfg</td>
<td></td>
</tr>
<tr class="even">
<td>11</td>
<td>Alert</td>
<td>addons/FontAwesome</td>
<td>Add a Alert node, show message from SMS group</td>
<td></td>
</tr>
<tr class="odd">
<td>12</td>
<td>Registration Form</td>
<td><p><strong>Nodes:</strong></p>
<p>1- Viewer</p>
<p>2- Alert (in tree)</p>
<p>3- awesome_button</p>
<p>4- DB_control (DB_create)</p>
<p>5- DB_form_request</p>
<p>6- panel_round</p>
<p>7- PopUp_options</p>
<p>8- /form/line_edit_panel</p>
<p>/DB/database.csv</p></td>
<td><p>4- Configuration</p>
<p>5- (instance) Set in FuncApp var (HTTPRequest_form = path: line_edit_panel)</p>
<p>8- (instance) Set in FuncApp var (line_edit_panel</p>
<p>= path: line_edit_panel)</p></td>
<td></td>
</tr>
<tr class="even">
<td>13</td>
<td>Background_scene</td>
<td></td>
<td>Set texture or background color</td>
<td></td>
</tr>
</tbody>
</table>

**MODULES IMPLEMENTATION**
<table>
<tbody>
<tr class="odd">
<td></td>
<td><strong>Module</strong></td>
<td><strong>Use</strong></td>
<td><strong>Demostration</strong></td>
</tr>
<tr class="even">
<td></td>
<td>Alert</td>
<td><p>var param = ["from:",text,"icon","color_text","color_icon"]</p>
<p>for i in get_tree().get_nodes_in_group("alert"):</p>
<p>i.click_awesome("alert_show",param)</p></td>
<td></td>
</tr>
</tbody>
</table>

