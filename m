From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 0/7] Detaching fbcon
Date: Tue, 06 Jun 2006 19:08:19 +0800
Message-ID: <44856223.9010606@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751209AbWFFLKT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

One of the limitations of the framebuffer console system is its inablity to
unload or detach itself from the console layer.  And once it loads, it also
locks in framebuffer drivers preventing their unload. Although the con2fbmap
utility does provide a means to unload individual drivers, it requires that at
least one framebuffer driver is loaded for use by fbcon.

With this change, it is possible to detach fbcon from the console layer. If it
is detached, it will reattach the boot console driver (which is permanently
loaded) back to the console layer so the system can continue to work.  As a
consequence, fbcon will also decrement its reference count of individual
framebuffer drivers, allowing all of these drivers to be unloaded even if
fbcon is still loaded.

Unless you use drivers that restores the display to text mode (rivafb and
i810fb, for example), detaching fbcon does require assistance from userspace
tools (ie, vbetools) for text mode to be restored completely.  Without the
help of these tools, fbcon will leave the VGA console corrupted. The methods
that can be used will be described in Documentation/fb/fbcon.txt.

Because the vt layer also increments the module reference count for each
console driver, fbcon cannot be directly unloaded.  It must be detached first
prior to unload.

Similarly, fbcon can be reattached to the console layer without having to
reload the module.  A nice feature if fbcon is compiled statically.

Attaching and detaching fbcon is done via sysfs attributes. A class device
entry for fbcon is created in /sys/class/graphics. The two attributes that
controls this feature are detach and attach. Two other attributes that are
piggybacked under /sys/class/graphics/fb[n] that are fbcon-specific,
'con_rotate' and 'con_rotate_all' are moved to fbcon.  They are renamed as
'rotate' and 'rotate_all' respectively.

Overall, this feature is a great help for developers working in the
framebuffer or console layer.  There is not need to continually reboot the
kernel for every small change. It is also useful for regular users who wants
to choose between a graphical console or a text console without having to
reboot.

Example usage for x86:

/* start in text mode */
modprobe xxxfb
modprobe fbcon
/* graphical mode with fbcon using xxxfb */
echo 1 > /sys/class/graphics/fbcon/detach
/* back to text mode, will produce corrupt display unless vbetool is used */
rmmod xxxfb
modprobe yyyfb
/* back to graphical mode with fbcon using yyyfb */

Before trying out this feature, please read Documentation/fb/fbcon.txt.
