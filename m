From: Rob Herring <robh@kernel.org>
Date: Mon, 07 Jan 2019 23:51:02 +0000
Subject: Re: [PATCH] fbdev: offb: Fix OF node name handling
Message-Id: <CAL_JsqKfmzA6E0PEKA-69haaO163YrNhoF7+oauE5Xd3JDTKgw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190107173132.27316-1-robh@kernel.org> <CA+7wUswqMNc1js6hyszYKVOeXrVPVDYLxSmZ97Uaqqo7u0Z9vQ@mail.gmail.com>
 <CA+7wUsyw8PLc2-4jnFVwkNg_u8H=FgOHQtBspKR8haLT-5NSwQ@mail.gmail.com>
In-Reply-To: <CA+7wUsyw8PLc2-4jnFVwkNg_u8H=FgOHQtBspKR8haLT-5NSwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Elimar Riesebieter <riesebie@lxtec.de>, LKML <linux-kernel@vger.kernel.org>, "# v4 . 11" <stable@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Mon, Jan 7, 2019 at 2:36 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Hi Rob,
>
> On Mon, Jan 7, 2019 at 9:11 PM Mathieu Malaterre <malat@debian.org> wrote:
> >
> > On Mon, Jan 7, 2019 at 6:31 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > Commit 5c63e407aaab ("fbdev: Convert to using %pOFn instead of
> > > device_node.name") changed how the OF FB driver handles the OF node
> > > name. This missed the case where the node name is passed to
> > > offb_init_palette_hacks(). This results in a NULL ptr dereference
> > > in strncmp and breaks any system except ones using bootx with no display
> > > node.
> > >
> > > Fix this by making offb_init_palette_hacks() use the OF node pointer and
> > > use of_node_name_prefix() helper function instead for node name
> > > comparisons. This helps in moving all OF node name accesses to helper
> > > functions in preparation to remove struct device_node.name pointer.
> > >
> > > Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")
> >
> > Looks good to me:
> >
> > ...
> > [    0.000000] Linux version 5.0.0-rc1+ (malat@debian.org) (gcc
> > version 6.3.0 20170516 (Debian 6.3.0-18)) #21 Mon Jan 7 21:03:53 CET
> > 2019
> > ...
> >
> > So here is my :
> >
> > Tested-by: Mathieu Malaterre <malat@debian.org>
>
> Just for curiosity, why would you keep:
>
>      if (strcmp(dp->name, "valkyrie") = 0)

Mainly just because I already have another patch to do that which I
haven't sent out.

Rob
