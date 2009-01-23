From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Fri, 23 Jan 2009 13:25:01 +0000
Message-ID: <20090123132501.GJ26184@n2100.arm.linux.org.uk>
References: <4978CD75.70203@epfl.ch>
	<Pine.LNX.4.64.0901222122150.7935@axis700.grange>
	<49798E4A.4030709@epfl.ch>
	<Pine.LNX.4.64.0901231040420.4463@axis700.grange>
	<4979A88A.5010102@epfl.ch>
	<Pine.LNX.4.64.0901231308040.4463@axis700.grange>
	<4979BFC1.1070504@epfl.ch>
	<Pine.LNX.4.64.0901231407030.6497@axis700.grange>
	<20090123131804.GI26184@n2100.arm.linux.org.uk>
	<4979C472.10707@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69) (envelope-from
	<linux+linux-fbdev-devel=lists.sourceforge.net@arm.linux.org.uk>)
	id 1LQM2l-0007SN-Qd for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 13:25:55 +0000
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LQM2b-0004o9-LA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jan 2009 13:25:55 +0000
Content-Disposition: inline
In-Reply-To: <4979C472.10707@epfl.ch>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Fri, Jan 23, 2009 at 02:21:54PM +0100, Valentin Longchamp wrote:
> OK this may be a problem: I use the toolchain that is built by
> OpeneEmbedded. I could give a try to another one. Where can I download
> the ones you use Guennadi or Russel ?

I build my own, direct from ftp.gnu.org.  For non-EABI stuff, I use
binutils 2.18 and gcc 3.4.3.  For EABI or ARMv7 stuff, I _have_ gcc
4.3.2 but I really don't trust or like it; I try to use gcc 3.4.3
where possible.

I used gcc 4.2.2 for EABI prior to needing ARMv7 support.

And yes, I do have to tweak things a bit to get gcc to build without
glibc - since all I'm interested in is a cross compiler for building
kernels.

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
