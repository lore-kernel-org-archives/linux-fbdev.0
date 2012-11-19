From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 19 Nov 2012 16:26:16 +0000
Subject: Re: [PATCH v3] video: Versatile Express DVI output driver
Message-Id: <1353342376.3303.32.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350405036-17997-1-git-send-email-pawel.moll@arm.com>
 <1351612732.6199.4.camel@hornet> <1353333377.3303.7.camel@hornet>
 <201211191543.51923.arnd@arndb.de>
In-Reply-To: <201211191543.51923.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, 2012-11-19 at 15:43 +0000, Arnd Bergmann wrote:
> * vexpress_dvi_fb_select uses the 'fb' argument as an index into
>   the registered_fb array, but does not check for overflow against
>   FB_MAX.=20

Uh, right. Will fix in a second.

> I think you need to use get_fb_info().

I was considering this, but it's a static. And I don't want to change
the fb core, as I'm planning to plug this driver into the "Generic
Panel/Display Framework" [1] that Laurent is working on when it's
available. Then I won't have to hack into the core at all...

[1] http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/=
52565

> * There is no documentation for the newly introduced sysfs interface.

Hm, I didn't want to do that, as it's currently just a debug feature -
there is no class symlink to the device available
(Documentation/ABI/testing/sysfs-devices) so there's no universal way of
describing the path to the device.

I'll do my best and post v4 soon.

Pawe=C5=82







