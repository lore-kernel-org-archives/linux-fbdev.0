From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 6/7] Detaching fbcon: Add capability to attach/detach
 fbcon
Date: Tue, 6 Jun 2006 15:12:10 -0700
Message-ID: <20060606151210.22751bce.akpm@osdl.org>
References: <4485624C.9070707@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751139AbWFFWMW@vger.kernel.org>
In-Reply-To: <4485624C.9070707@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 19:09:00 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> Add the ability to detach and attach the framebuffer console to and from
> the vt layer. This is done by echo'ing any value to sysfs attributes located
> in class/graphics/fbcon. The two attributes are:
> 
>       attach - bind fbcon to the vt layer
>       detach - unbind fbcon from the vt layer

That's a bit unusual.  Normally a bind or unbind operation will operate
primarily upon the thing which is bound to, not upon the thing which is
bound.

I assume it makes sense this way, given the way the vt layer operates.  But
it rather rules out binding the fbcon layer to anything apart from the vt
layer (just thinking about it design-wise).

ummm, expressing it differently:

	echo "bind fbcon" > /sys/whatever/some-vt-file
	echo "unbind fbcon" > /sys/whatever/some-vt-file

would be more typical usage.

> Once fbcon is detached from the vt layer, fbcon can be unloaded if compiled as
> a module. This feature is quite useful for developers who work on the
> framebuffer or console subsystem. This is also useful for users who want to
> go to text mode or graphics mode without having to reboot.

Do we have a place where this can be documented?

> Directly unloading the fbcon module is not possible because the vt layer
> increments the module reference count for all bound consoles.  Detaching fbcon
> decrements the module reference count to zero so unloading becomes possible.

Right.  So the vt layer should be told to let go of the fbcon layer.  It's
a vt operation, not an fbcon one, yes?
