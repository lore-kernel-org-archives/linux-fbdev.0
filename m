From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: EGL_MESA_screen_surface proposal
Date: Tue, 15 Mar 2005 11:28:33 -0500
Message-ID: <9e4733910503150828ecf5a1b@mail.gmail.com>
References: <4236F0A8.4000004@tungstengraphics.com>
	<9e47339105031507064a68630f@mail.gmail.com>
	<4236FC79.5000909@tungstengraphics.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <4236FC79.5000909@tungstengraphics.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Brian Paul <brian.paul@tungstengraphics.com>
Cc: Xserver development <xorg@freedesktop.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI-EGL <dri-egl@lists.freedesktop.org>

I cc'd this onto the other lists to get more opinions. Maybe we can
turn this into a workable concept.

On Tue, 15 Mar 2005 08:17:13 -0700, Brian Paul
<brian.paul@tungstengraphics.com> wrote:
> Perhaps the eglShowSurface() and eglScreenMode() functions should be
> combined so the new surface and new display mode can be validated
> together.  That way, the undefined state between setting the new
> surface and new mode can be avoided.

In one of the other threads (on x.org&fbdev) people are arguing that
mode setting and surface selection should not be combined. I think
their concern comes from mode setting code is in fbdev and their
allocation code is somewhere else.

The problem is that fbdev doesn't have a memory manager so it has no
concept of where the surfaces are. It relies on some other piece of
software manage the surfaces. Maybe we should teach fbdev about the
concept of surfaces.

Initially the radeonfb dev driver would only know about two surfaces,
one for each head. Name them default. Setting the mode on either head
would have an implied parameter surface=default. surface=default is a
special case since the surface type is mutable into what ever the mode
requires.

fbdev could then be extended to have a plugable API for enumerating
surfaces. DRM would add other surfaces to this list each with a name.
Now you can set the mode and specific surface=my_new_surface. If the
mode and surface are incompatible you get an error.

Another twist would be to set the mode just by specificing the surface
name. That would cause a mode to be picked that can display the
surface.






-- 
Jon Smirl
jonsmirl@gmail.com
