From: Brian Paul <brian.paul@tungstengraphics.com>
Subject: Re: EGL_MESA_screen_surface proposal
Date: Wed, 16 Mar 2005 08:04:38 -0700
Message-ID: <42384B06.1010901@tungstengraphics.com>
References: <4236F0A8.4000004@tungstengraphics.com>	
	<9e47339105031507064a68630f@mail.gmail.com>	
	<4236FC79.5000909@tungstengraphics.com>	
	<9e4733910503150828ecf5a1b@mail.gmail.com>	
	<1110904613.9080.62.camel@lnx-1cv4-4-110>
	<9e47339105031520304154e567@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105031520304154e567@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Xserver development <xorg@freedesktop.org>, DRI-EGL <dri-egl@lists.freedesktop.org>

Jon Smirl wrote:
> On Tue, 15 Mar 2005 11:36:53 -0500, Michel Danzer <mdanzer@ati.com> wrote:
> 
>>On Tue, 2005-03-15 at 11:28 -0500, Jon Smirl wrote:
>>
>>>On Tue, 15 Mar 2005 08:17:13 -0700, Brian Paul
>>><brian.paul@tungstengraphics.com> wrote:
>>>
>>>>Perhaps the eglShowSurface() and eglScreenMode() functions should be
>>>>combined so the new surface and new display mode can be validated
>>>>together.  That way, the undefined state between setting the new
>>>>surface and new mode can be avoided.
>>
>>Makes sense to me.
> 
> 
> What if I just want to show another surface without changing the mode?
> I could still use a combined version and since the mode matches the
> mode won't actually get changed?

Right.  The combined function can just as well be used to change the 
screen's current mode _or_ current surface.  You don't have to change 
both.

-Brian
