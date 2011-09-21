From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 21 Sep 2011 08:29:54 +0000
Subject: Re: [PATCH] fsl-diu-fb: remove the ioctl interface
Message-Id: <20110921102954.151d7cde@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308691655-3416-1-git-send-email-timur@freescale.com>
	<20110622003853.1041385c@wker> <4E012586.7050808@freescale.com>
	<20110622221143.503add74@wker>
	<CAOZdJXUZsByLorWZNtDRMzsezF_qVX62+8zfiMKJqMMhCD2i3g@mail.gmail.com>
In-Reply-To: <CAOZdJXUZsByLorWZNtDRMzsezF_qVX62+8zfiMKJqMMhCD2i3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wed, 21 Sep 2011 02:10:42 +0000
Tabi Timur-B04825 <B04825@freescale.com> wrote:
...
> The definitions of MFB_SET_PIXFMT and MFB_GET_PIXFMT are wrong:
> 
> #define MFB_SET_PIXFMT          0x80014d08
> #define MFB_GET_PIXFMT          0x40014d08
> 
> The "01" is the size.  However, these ioctls take a __u32 as a parameter.
> 
> This means that I have to fix the definitions to this:
> 
> #define MFB_SET_PIXFMT          _IOW('M', 8, __u32)
> #define MFB_GET_PIXFMT          _IOR('M', 8, __u32)
> 
> This will change the values and break binary compatibility with your
> applications.  Are you okay with that?

yes. the app will be fixed for updated kernel.

> > Other ioctls can be removed. I'm not sure if someone
> > uses FBIOGET_GWINFO. If there are no objections from
> > other people, it can also be dropped.
> 
> I'm going to remove FBIOGET_GWINFO because no one is using it, and the
> ioctl value is malformed (it doesn't define a direction or size).

okay. 

Thanks,
Anatolij
