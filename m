From: Dave Airlie <airlied@gmail.com>
Date: Mon, 21 Mar 2011 05:58:04 +0000
Subject: Re: Regression: black screen with Radeon KMS in 2.6.38 (2.6.37.4
Message-Id: <AANLkTind1i+jHCeXPYGJtEamgbnvgtWTGB6BXzNsEzUE@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D86E4E6.3040403@tds.net>
In-Reply-To: <4D86E4E6.3040403@tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, Mar 21, 2011 at 3:40 PM, John Lindgren <john.lindgren@tds.net> wrot=
e:
> Hi,
>
> I want to report a bug in the Linux kernel 2.6.38. =A0Loading the radeon
> module causes the console to go completely blank (laptop backlight on, but
> nothing displayed). =A0The system still responds to ctrl-alt-del and rebo=
ots.
> =A0This is a regression from the previous kernel, 2.6.37.4, where kernel =
mode
> setting works flawlessly.
>
> With radeon.modeset=3D0, or with the module blacklisted, the system boots
> fine, and I can use X, but without the powersaving features available
> through KMS.

Please post to dri-devel list, but my first guess is missing fbcon or
something like that.

can't tell without complete dmesg.

Alternative file a bug on kernel bugzilla, with the complete dmesg attached.

Dave.
