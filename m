From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Wed, 12 Sep 2012 21:33:56 +0000
Subject: Re: [PATCH v6 0/4] Runtime Interpreted Power Sequences
Message-Id: <20120912213355.GA3342@lizard>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <5050FE28.2080502@wwwdotorg.org>
In-Reply-To: <5050FE28.2080502-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Wed, Sep 12, 2012 at 03:27:04PM -0600, Stephen Warren wrote:
> On 09/12/2012 03:57 AM, Alexandre Courbot wrote:
> > New revision of the power sequences, taking as usual the feedback that was
> > kindly provided about the last version.
> > 
> > I think now is a good time to discuss integrating this and to start looking for
> > a maintainer who would be willing to merge this into his/her tree (I am
> > especially thinking about the power framework maintainers, since this is where
> > the code is right now.
> 
> The other alternative is for you to maintain this going forward; I
> believe that would be as simple as:
> 
> * Create a patch to add yourself to MAINTAINERS for the
> drivers/power/power_seq/ directory.
> 
> * Get a kernel.org account, push this patch to a branch there, and add
> the branch into linux-next.
> 
> * Send a pull request to Linus at the appropriate time.
> 
> * Ongoing: Accept any patches, perform any maintenance required, etc.
> 
> Does anyone see any issue with Alexandre doing this? Nobody else has
> volunteered yet:-)

Yup, looks like the best way.

Anton.
