From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 6/7] Detaching fbcon: Add capability to attach/detach
 fbcon
Date: Wed, 07 Jun 2006 07:17:14 +0800
Message-ID: <44860CFA.4040409@gmail.com>
References: <4485624C.9070707@gmail.com> <20060606151210.22751bce.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751346AbWFFXRj@vger.kernel.org>
In-Reply-To: <20060606151210.22751bce.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 06 Jun 2006 19:09:00 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> Add the ability to detach and attach the framebuffer console to and from
>> the vt layer. This is done by echo'ing any value to sysfs attributes located
>> in class/graphics/fbcon. The two attributes are:
>>
>>       attach - bind fbcon to the vt layer
>>       detach - unbind fbcon from the vt layer
> 
> That's a bit unusual.  Normally a bind or unbind operation will operate
> primarily upon the thing which is bound to, not upon the thing which is
> bound.

I'm not against this.

> 
> I assume it makes sense this way, given the way the vt layer operates.  But
> it rather rules out binding the fbcon layer to anything apart from the vt
> layer (just thinking about it design-wise).

The vt-layer is different in that the device themselves bind to it, not
the other way around.  As I've told Jon, if someone change the vt-layer so
it behaves in a standard way, I'm all for it (that someone is probably me).

But thinking about it, it is probably not very difficult to change the
vt-layer.  We just make the vt-layer keep a list of registered drivers. And 
we already have /sys/class/tty/console, so I can put the attribute there
for bind and unbind.

> 
> ummm, expressing it differently:
> 
> 	echo "bind fbcon" > /sys/whatever/some-vt-file
> 	echo "unbind fbcon" > /sys/whatever/some-vt-file
> 
> would be more typical usage.
> 
>> Once fbcon is detached from the vt layer, fbcon can be unloaded if compiled as
>> a module. This feature is quite useful for developers who work on the
>> framebuffer or console subsystem. This is also useful for users who want to
>> go to text mode or graphics mode without having to reboot.
> 
> Do we have a place where this can be documented?

In Documentation/fb/fbcon.txt.

> 
>> Directly unloading the fbcon module is not possible because the vt layer
>> increments the module reference count for all bound consoles.  Detaching fbcon
>> decrements the module reference count to zero so unloading becomes possible.
> 
> Right.  So the vt layer should be told to let go of the fbcon layer.  It's
> a vt operation, not an fbcon one, yes?

Yes. I'll take a stab at doing it this way. 

Tony
 
