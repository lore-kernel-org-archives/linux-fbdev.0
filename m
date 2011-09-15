From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Sep 2011 05:57:45 +0000
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Message-Id: <1316066265.1880.6.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
	 <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
	 <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
	 <CAF6AEGuhjZgH9zFuigjfvHGM9r7jSLY2TTCD0LjZbT+Ubrb12A@mail.gmail.com>
	 <CAP5A+B87w6Hir-0+SNnckQaDcO=ixgq-U8pFo2U42dwQgtUrZQ@mail.gmail.com>
	 <1315984468.2172.10.camel@deskari>
	 <CAP5A+B9uDj4kCowbEKgX1J74zWvBarp64Cn4YVom-a8BYtab4w@mail.gmail.com>
	 <1315989282.2172.36.camel@deskari>
	 <CAP5A+B-GWN+oJhcVbB24swfmH=-dE4sViNqF+hX6=D1owzOLzA@mail.gmail.com>
	 <1315990630.2172.51.camel@deskari>
	 <CAP5A+B9Me0RX3PY7Uwf=VuaHzaPtoNY0q9gxFg9H-Q3N2giC2Q@mail.gmail.com>
	 <1316009509.2118.6.camel@deskari>
	 <CAP5A+B-_19gPDmjJGBHpcDcGPGyt9QvFXFwgjGPUqr-QY9SPJg@mail.gmail.com>
In-Reply-To: <CAP5A+B-_19gPDmjJGBHpcDcGPGyt9QvFXFwgjGPUqr-QY9SPJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "K, Mythri P" <mythripk@ti.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Thu, 2011-09-15 at 11:11 +0530, K, Mythri P wrote:
> Hi,
> 
> On Wed, Sep 14, 2011 at 7:41 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> > Yes, you are right, detect() does not "know" if the monitor has changed
> > between polls, so both notification and polling are needed. I
> > implemented only polling as there's no HPD event mechanism yet in
> > omapdss, and also because this was simple and gives DRM basic ability to
> > detect a monitor.
> >
> If it is needed for DRM then it is fine, but with detect renamed to
> poll. By next week i should have a patch ready for HPD event
> mechanism.

What is wrong with "detect"? It detects if there's a display connected.
It can be used in polling manner, trying it every n seconds, but it
should also be used even if you use HPD event. I think the normal
sequence would be something like:

1) register HPD event
2) use detect() to see if a monitor is already connected

 Tomi


