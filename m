From: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: EGL_MESA_screen_surface proposal
Date: Tue, 15 Mar 2005 23:44:13 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503152343290.17439@node2.an-vo.com>
References: <4236F0A8.4000004@tungstengraphics.com>
	<9e47339105031507064a68630f@mail.gmail.com>
	<4236FC79.5000909@tungstengraphics.com>
	<9e4733910503150828ecf5a1b@mail.gmail.com>
	<1110904613.9080.62.camel@lnx-1cv4-4-110>
	<9e47339105031520304154e567@mail.gmail.com>
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Michel Danzer <mdanzer@ati.com>, Xserver development <xorg@freedesktop.org>, DRI-EGL <dri-egl@lists.freedesktop.org>



On Tue, 15 Mar 2005, Jon Smirl wrote:

> On Tue, 15 Mar 2005 11:36:53 -0500, Michel Danzer <mdanzer@ati.com> wrote:
>> On Tue, 2005-03-15 at 11:28 -0500, Jon Smirl wrote:
>>>
>>> On Tue, 15 Mar 2005 08:17:13 -0700, Brian Paul
>>> <brian.paul@tungstengraphics.com> wrote:
>>>> Perhaps the eglShowSurface() and eglScreenMode() functions should be
>>>> combined so the new surface and new display mode can be validated
>>>> together.  That way, the undefined state between setting the new
>>>> surface and new mode can be avoided.
>>
>> Makes sense to me.
>
> What if I just want to show another surface without changing the mode?
> I could still use a combined version and since the mode matches the
> mode won't actually get changed?

Have a flag that describes what needs to be changed ?

                      best

                         Vladimir Dergachev

>
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> _______________________________________________
> xorg mailing list
> xorg@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/xorg
>
