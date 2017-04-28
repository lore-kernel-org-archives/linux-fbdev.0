From: "Olimpiu Dejeu" <olimpiu@arcticsand.com>
Date: Fri, 28 Apr 2017 15:04:11 +0000
Subject: RE: [PATCH v8 1/3] backlight arcxcnn add arc to vendor prefix
Message-Id: <355401d2c030$b2aa63c0$17ff2b40$@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1489607133-7870-1-git-send-email-olimpiu@arcticsand.com> <CAL_JsqJ+=fQ2e752iCHs0dbdrkotuDtKp=2Z2_xnyCtMnxWV8A@mail.gmail.com> <2aac01d2bd24$17449a90$45cdcfb0$@arcticsand.com> <000301d2bde2$10822970$31867c50$@gmail.com> <CAMuHMdXbKH5hojvj+N8W0h7znw8iAGo1Y1NyFHjrfQ1n0-XQKA@mail.gmail.com> <001301d2bf7d$919d2d60$b4d78820$@gmail.com>
In-Reply-To: <001301d2bf7d$919d2d60$b4d78820$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Jingoo Han' <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'Rob Herring' <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Lee Jones' <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Geert Uytterhoeven' <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Linux Fbdev development list' <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Dodge <bdodge-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>, 'Joe Perches' <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, 'Daniel Thompson' <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> On Thursday, April 27, 2017 8:37 AM, Geert Uytterhoeven wrote:
> > On Tue, Apr 25, 2017 at 6:36 PM, Jingoo Han <jingoohan1@gmail.com> wrote:
> > > On Monday, April 24, 2017 1:56 PM, Olimpiu Dejeu wrote:
> > >>
> > >> On Mon, April 24, 2017 11:10 AM, Rob Herring < robh@kernel.org> wrote:
> > >>
> > >> > On Wed, Mar 15, 2017 at 2:45 PM, Olimpiu Dejeu
> > <olimpiu@arcticsand.com>
> > >> wrote:
> > >> >> backlight: Add arc to vendor prefixes
> > >> >> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> > >> >> ---
> > >> >> v8:
> > >> >> - Version to match other patches in set
> > >> >>
> > >> >>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> > >> >>  1 file changed, 1 insertion(+)
> > >> >>
> > >> >> diff --git 
> > >> >> a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > >> >> b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > >> >> index 16d3b5e..6f33a4b 100644
> > >> >> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > >> >> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > >> >> @@ -28,6 +28,7 @@ andestech     Andes Technology Corporation
> > >> >>  apm    Applied Micro Circuits Corporation (APM)
> > >> >>  aptina Aptina Imaging
> > >> >>  arasan Arasan Chip Systems
> > >> >> +arc    Arctic Sand
> > >>
> > >> >arc is also a cpu arch. While not a vendor, it could be confusing. 
> > >> >How
> > >> about "arctic" >instead?
> > >>
> > >> Rob, will do, i.e. I will change it to "arctic"
> > >
> > > Hi Olimpiu,
> > >
> > > Oh, "arc" and "arctic" is totally different.
> > > In my opinion, one of the purposes of DT is to describe hardware stuffs.
> > > So, please use more detailed words.
> > 
> > Already acquired by Murata?

> Yes, Murata already announced the agreement of acquisition. [1]

> To Olimpiu Dejeu,
> What is your company's plan about naming?
> The brand name 'Artic Sand' will be continued or not?

The brand name 'Arctic Sand' will be continued 

> If not, you should replace 'Artic Sand' with 'Murata'.
> As you said earlier, changing DT names is not easy after merging.

> Best regards,
> Jingoo Han


