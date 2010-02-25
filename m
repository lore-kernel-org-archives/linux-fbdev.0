From: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Date: Thu, 25 Feb 2010 17:52:40 +0000
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Message-Id: <d8539fd26220388f501300c92b12bbe1.squirrel@intranet.cs.nmsu.edu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100221002001.0a7e05a7@neptune.home>
    <20100224170049.0d04af3c@neptune.home>
    <alpine.LNX.2.00.1002251201430.30967@pobox.suse.cz>
    <20100225123214.0523a310@neptune.home>
In-Reply-To: <20100225123214.0523a310-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?iso-8859-1?Q?Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>


Bruno Pr=C3=A9mont wrote:
> The one for deferredio refresh rate should ideally go below fb device
> (and I guess that might also be of use for other users of deferredio)
>

I'm testing a patch now. I didn't expect anyone else would really need it,
but it does help with throttling bus traffic from userspace.

If it's in fbsysfs.c we can both eliminate it from our drivers.

--=20

Rick

