From: Julia Cartwright <juliac@eso.teric.us>
Date: Tue, 26 Jun 2018 18:59:00 +0000
Subject: Re: simple-framebuffer enquire
Message-Id: <20180626185900.GA20755@kryptos.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
 <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com>
 <CAOf5uwk2cf_+27nk9i9MQmbfJ8LCfPYopkcX__9M64jMYmhu1A@mail.gmail.com>
 <CAOf5uwkEuDgAJ7e8rNFyiKpUZPA3NhQGREtOGsm1EVSofW3rzQ@mail.gmail.com>
 <233d6808-4d44-9e47-7e3f-4f35cf731706@redhat.com>
 <CAOf5uwkJimhGJd_BtUuDyxaD5-ZYGe3JZtgC4pDKc_jnvaV21g@mail.gmail.com>
 <CAOf5uwnVoXw1MA=n3vphMhtto=fc+NVf11idLF8nwC6JCvf4+A@mail.gmail.com>
 <7b996681-3a94-1f93-10c0-5369fe843cbc@redhat.com>
 <CAOf5uwmxZxxKG0CnstnNaTYdt-1+=YZHr8eSac5TdwfANdobxQ@mail.gmail.com>
 <996603c6-9779-7412-d998-bd7b49194490@redhat.com>
In-Reply-To: <996603c6-9779-7412-d998-bd7b49194490@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, artlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Jun 26, 2018 at 08:44:58PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 26-06-18 18:35, Michael Nazzareno Trimarchi wrote:
[..]
> > cat memblock/reserved
> >     0: 0x80004000..0x80007fff
> >     1: 0x80100000..0x81e030b3
> >     2: 0x83000000..0x83007fff
> >     3: 0x84000000..0x85ffffff
> >     4: 0x86fa2000..0x87021fff
> > 
> > +       reserved-memory {
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges;
> > +
> > +               display_reserved: framebuffer@86fa2000 {
> > +                       reg = <0x86fa2000 0x80000>;
> > +               };
> > +
> > +       };
[..]
> > Still have the same on ioremap.
> 
> Hmm, I guess the kernel does map the entire region its get
> passed and simply makes sure to not touch the reserved mem,
> where as with the changes to the passed in mem-region the
> sunxi u-boot code does the memory does not get mapped by
> the kernel at all ?

If the intent is to reserve memory _and_ prevent it from being included
in the kernel's linear map, then it is also necessary to include the
'no-map' property for this reserved-mem node.

From Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt:

   no-map (optional) - empty property
       - Indicates the operating system must not create a virtual mapping
         of the region as part of its standard mapping of system memory,
         nor permit speculative access to it under any circumstances other
         than under the control of the device driver using the region.

    Julia
