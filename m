From: Alexandre Courbot <gnurou@gmail.com>
Date: Thu, 22 Nov 2012 02:01:34 +0000
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Message-Id: <CAAVeFuK_V6nb874bygioi35mFNxaWuveKOedLT=YYsP4JfVqgA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
 <13540495.epaCf4JVn9@percival> <50ACB59B.4090404@iki.fi>
 <20121121114018.GA31576@avionic-0098.adnet.avionic-design.de>
 <50ACC341.3090204@ti.com>
 <20121121130039.GA12191@avionic-0098.adnet.avionic-design.de>
 <50ACD7DC.5060405@ti.com>
 <CAAVeFuJofYwj926=3v0ApBCq_vNhCdC1PnzDc-B3d=LL_L40Uw@mail.gmail.com>
 <20121121151209.GA4048@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20121121151209.GA4048@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 22, 2012 at 12:12 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Thu, Nov 22, 2012 at 12:02:47AM +0900, Alexandre Courbot wrote:
>> Mmmm so maybe I am misinterpreting things, but it looks like we
>> have just buried the power sequences here, haven't we?
>
> I don't think so. In fact I was just starting to think that maybe for
> Tegra we could have a generic panel driver which used power sequences
> to abstract away the pin differences for powering up the panel. Since
> most likely that will be where the differences are there is a lot of
> potential to factor things out into sequences.
>
> Perhaps what we may want to postpone for now is the DT representation
> since that's what Tomi and Grant seem to be mostly opposed to.

The thing I don't understand here is why would anyone want power
sequences without the DT representation. Guys, that's the whole point! :)

If we are to implement things into drivers, then callback functions
are going to serve us just as well - even better, for they are more
flexible. All we need to do is define a dedicated ops structure and
have the driver plug the right callback functions depending on the
"compatible" property of the DT device node. We don't need a framework
for that.

And if we are not going to use power seqs that's probably what we
should do in order to get panels to work on Tegra boards for now. Then
see how things turn out with the panel framework and whether there is
a use for power seqs in it. But by the meantime, I don't see any
motivation to merge power seqs sans DT support.

Alex.
