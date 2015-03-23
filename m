From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 23 Mar 2015 14:19:58 +0000
Subject: Re: [PATCH 0/13] staging: sm750: reformat sm750.c
Message-Id: <20150323140758.GC27897@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150322230718.GA16751@x230-arch.club.entropia.de>
In-Reply-To: <20150322230718.GA16751@x230-arch.club.entropia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Mar 23, 2015 at 02:48:03PM +0100, tofu wrote:
> On 03/23/2015 02:11 PM, Sudip Mukherjee wrote:
> > On Mon, Mar 23, 2015 at 02:20:05PM +0300, Dan Carpenter wrote:
> >> These are going to conflict with Lorenzo's patches.
> > 
> > i just checked and informed Lorenzo that his patchset is not applying
> > to staging-testing, and this patchset also is not applying. Greg has
> > already applied patches of Raghavendra and Ricardo Ribalda Delgado.
> > 
> > Michel - please refresh your patchset against staging-testing after
> > making the changes that Dan has suggested.
> I'll update it tonight and rebase it to staging-testing. 

my apologies. your patchset is applying properly, but it is not
applying if i apply Lorenzo's patches first. And in all probability
Greg will apply that first as that has reached his inbox first.
so better will be if you apply Lorenzo's patches to your tree and
then prepare your patches and just write a small comment in your
patch that your patchset depends on the patchset sent by Lorenzo.

regards
sudip
