From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: Use the correct MSR number for panel support
Date: Tue, 30 Oct 2007 15:33:23 -0600
Message-ID: <20071030213323.GE14814@cosmic.amd.com>
References: <20071026145301.14168.19412.stgit@cosmic.amd.com>
	<472674B0.9080001@zytor.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ImyhE-0001ua-2t for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 14:32:24 -0700
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=outbound9-dub-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ImyhC-0006fB-6C
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 14:32:24 -0700
In-Reply-To: <472674B0.9080001@zytor.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-info@geode.amd.com, linux-kernel@vger.kernel.org, tibor.osztodi@bbraun.com

On 29/10/07 17:02 -0700, H. Peter Anvin wrote:
> Jordan Crouse wrote:
> > From: Jordan Crouse <jordan.crouse@amd.com>
> > 
> > A relatively recent version of the Geode LX datasheet listed the wrong
> > address for one of the MSRs that controls TFT panels, resulting in 
> > breakage.  This patch corrects the MSR address.
> > 
> > Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> > ---
> > 
> >  drivers/video/geode/lxfb.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/video/geode/lxfb.h b/drivers/video/geode/lxfb.h
> > index 6c227f9..ca13c48 100644
> > --- a/drivers/video/geode/lxfb.h
> > +++ b/drivers/video/geode/lxfb.h
> > @@ -33,7 +33,7 @@ void lx_set_palette_reg(struct fb_info *, unsigned int, unsigned int,
> >  
> >  #define MSR_LX_GLD_CONFIG    0x48002001
> >  #define MSR_LX_GLCP_DOTPLL   0x4c000015
> > -#define MSR_LX_DF_PADSEL     0x48000011
> > +#define MSR_LX_DF_PADSEL     0x48002011
> >  #define MSR_LX_DC_SPARE      0x80000011
> >  #define MSR_LX_DF_GLCONFIG   0x48002001
> >  
> 
> Please put MSR indicies in <asm-x86/msr-index.h> and/or a separate 
> include file.

The Geode has zillions upon zillions of MSRs (all of them being Geode 
specific), so putting them in asm-x86/msr-index.h would be a bad idea
for both you and me.  But tossing them into a asm-x86/geode-msr.h file
would be good for 2.6.25.  I'll get working on that.

In the mean time, this particular #define is already in the tree, and this
patch fixes serious breakage, so I would really like to see it hit 2.6.24,
if we can.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
