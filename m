From: Jon Smirl <jonsmirl@gmail.com>
Subject: Reworking sysfs attributes for fbdev
Date: Mon, 14 Mar 2005 22:43:27 -0500
Message-ID: <9e47339105031419437348829a@mail.gmail.com>
References: <200503111331.41352.ajax@nwnk.net>
	 <9e47339105031114196dbffd88@mail.gmail.com>
	 <42322050.9070206@tungstengraphics.com>
	 <9e47339105031115307868b476@mail.gmail.com>
	 <423230B3.2080202@tungstengraphics.com>
	 <9e4733910503111708d1e6856@mail.gmail.com>
	 <4234C39B.1010702@tungstengraphics.com>
	 <9e473391050313164572435dd4@mail.gmail.com>
	 <4235B5E1.6080406@tungstengraphics.com>
	 <9e473391050314091173cfbd0d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DB2xz-0005R9-QQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 19:43:35 -0800
Received: from wproxy.gmail.com ([64.233.184.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DB2xy-0002nJ-7H
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 19:43:35 -0800
Received: by wproxy.gmail.com with SMTP id 36so81wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 19:43:27 -0800 (PST)
In-Reply-To: <9e473391050314091173cfbd0d@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: dri-egl@lists.freedesktop.org, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Some discussion on the dri-egl list points out that the new mode
setting sysfs attributes for fbdev are too limited. Below is a
proposal I made on the dri-egl list.

To implement this for fbdev I need to know the right set of of
attribute value pairs. Some obvious ones are:

name=string
width=number
height=number
depth=number
refresh=number
interlace= yes | no | double
type = detailed|standard|vesa|user
sync = horizonatal_high | vertical_high | external | composite |
broadcast | green
left=number
right=number
lower=number
upper=number
hsync=number
vsync=number
pixclock=number

Right now fb0/modes is set by passing in an array of fb_videomode
structs. To convert this to attribute value pair I needs the full set
so that no info is lost.

If the mode and depth are independent variables we can end up with a
combo that exceeds monitor or hardware bandwidth. Would it be better
to combine the depth into the modes list? or if you try to set a
mode/depth that has too much bandwidth just select a lower bandwidth
mode automatically? Adding the depth to the modelist will triple the
number of entries.

Now that an attribute/value pair scheme has been proposed I like it a
lot better than what I implemented.

---------- Forwarded message ----------
From: Jon Smirl <jonsmirl@gmail.com>
Date: Mon, 14 Mar 2005 12:11:52 -0500
Subject: Re: Native surface creation
To: Brian Paul <brian.paul@tungstengraphics.com>
Cc: dri-egl@lists.freedesktop.org


On Mon, 14 Mar 2005 09:03:45 -0700, Brian Paul
<brian.paul@tungstengraphics.com> wrote:
> It's clear that you're working at a lower level of implementation
> detail than I am in trying to specify an EGL API extension.

I'm working right at the hardware implementing the modesetting.

A major thing being fixed is to allow normal users to set modes
without being root. Writing arbitrary modelines let you burn up
monitors so it has to be a root operation. To get around the need to
be root a fixed list of modes is exposed and you have to choose from
the list.

Right now the interface for this is very human readable in sysfs:
cat /sys/class/graphics/fb0/modes  --- list of mode names in human readable form
echo name >/sys/class/graphics/fb0/mode -- set one of the modes from the list

This is in current linus bk and it works with fbcon but it isn't
machine friendly, it relies on the human to know what the mode names
mean.

I could alter the attributes to work like this:

echo "width=1000, height=800, depth=32" >/sys/class/graphics/fb0/mode
would pick the closest mode and set it

echo "HDTV 1080i" >/sys/class/graphics/fb0/mode
would search the names since there is no equal sign.

cat /sys/class/graphics/fb0/mode
name="HDTV 720P", width=1024, height=720, depth=32, interlace=no, refresh=60

cat /sys/class/graphics/fb0/modes -- read only
name="v:1024x768", width=1024, height=768, depth=32, interlace=no, refresh=60
name="HDTV 720P", width=1024, height=720, depth=32, interlace=no, refresh=60
name="HDTV 1080i", width=1280, height=1080, depth=32, interlace=yes, refresh=60

I'll also change the root priv attribute that builds the mode list to
take in attribute/value pairs but egl can't change the list.

>
> typedef unsigned int EGLMode;
>
> EGLBoolean eglChooseMode(EGLDisplay dpy, const EGLint *attrib_list,
> EGLMode *modes, EGLint modes_size, EGLint *num_modes);
translates to
open("/sys/class/graphics/fb0/mode")
write("width=1000, height=800, depth=32");
close()
>
> EGLBoolean eglGetModes(EGLDisplay dpy, EGLint screen_number, EGLMode
> *modes, EGLint modes_size, EGLint *num_modes);
translates to
open("/sys/class/graphics/fb0/modes")
read()
close()
>
> EGLBoolean eglGetModeAttribMESA(EGLDisplay dpy, EGLMode mode, EGLint
> attribute, EGLint *value);

I can only do this for the currently active mode.

Note that the list of modes can change due to a monitor hotplug. This
will generate a hal/dbus event.

>
> They mirror the EGL Config functions.  Among the attribute tokens
> would be: EGL_WIDTH, EGL_HEIGHT, EGL_DEPTH, EGL_REFRESH_RATE, etc.
>

>
> -Brian
>

--
Jon Smirl
jonsmirl@gmail.com


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
