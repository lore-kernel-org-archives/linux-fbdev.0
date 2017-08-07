From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 07 Aug 2017 15:02:05 +0000
Subject: Re: [PATCH] video: fbdev: Convert to using %pOF instead of full_name
Message-Id: <11214112.PD8VBvCJLW@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170718214516epcas5p41593e7a72c2abb4ab7f78934027679fb@epcas5p4.samsung.com>
        <4331639.hUALxSEUjp@amdc3058>
        <CAL_JsqLy44aZdGcH7mGbmfQ49DTXU7fwoed8UCuaNEMVc_M8FQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLy44aZdGcH7mGbmfQ49DTXU7fwoed8UCuaNEMVc_M8FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tuesday, August 01, 2017 12:24:53 PM Rob Herring wrote:
> On Tue, Aug 1, 2017 at 8:47 AM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On Tuesday, July 18, 2017 04:43:36 PM Rob Herring wrote:
> >> Now that we have a custom printf format specifier, convert users of
> >> full_name to use %pOF instead. This is preparation to remove storing
> >> of the full path string for each node.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >> Cc: linux-fbdev@vger.kernel.org
> >
> > The patch Looks fine to me. Do you want me to merge it through fbdev
> > tree or do you have some other plan for %pOF conversion patches?
> 
> Please take thru the fbdev tree.

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

