import tkinter as tk
import tkinter.messagebox as messagebox
root = tk.Tk()

def on_closing():
    pass
    if messagebox.askokcancel("Quit", "Do you want to quit?"):
        root.destroy()

root.protocol("WM_DELETE_WINDOW", on_closing)
root.mainloop()