From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 21 Jun 2018 10:39:42 +0000
Subject: Re: [PATCH v2] video: fbdev: pxafb: zero allocated memory for video modes
Message-Id: <2385194.7sDUJuWH6v@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180619131332.23741-1-daniel@zonque.org>
In-Reply-To: <20180619131332.23741-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, June 21, 2018 11:22:35 AM Robert Jarzmik wrote:
> Daniel Mack <daniel@zonque.org> writes:
> 
> > On Tuesday, June 19, 2018 10:11 PM, Robert Jarzmik wrote:
> >> Daniel Mack <daniel@zonque.org> writes:
> >>
> >>> When parsing the video modes from DT properties, make sure to zero out
> >>> memory befor using it. This is important because not all fields in the mode
> >> s/befor/before/
> >>
> >
> > Yeah, seen this too after sending. Should I resend, or can this be amended when
> > applying?
> I think this question is for Bartlomiej, as fbdev is his tree ...

I will fix this typo while applying, no need for resend..

> >> This taken care of ...
> >> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

