From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: Re: [PATCH 2/4 v8] i.MX31: Image Processing
	Unit DMA and IRQ drivers
Date: Thu, 22 Jan 2009 20:48:05 +0100
Message-ID: <4978CD75.70203@epfl.ch>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
	<Pine.LNX.4.64.0901081857170.6387@axis700.grange>
	<4978C01B.8080707@epfl.ch>
	<Pine.LNX.4.64.0901221959100.7935@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <valentin.longchamp@epfl.ch>) id 1LQ5XI-0006BS-N6
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 19:48:20 +0000
Received: from smtp3.epfl.ch ([128.178.224.226])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LQ5X8-0002C0-Su for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 19:48:20 +0000
In-Reply-To: <Pine.LNX.4.64.0901221959100.7935@axis700.grange>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

Guennadi Liakhovetski wrote:
> On Thu, 22 Jan 2009, Valentin Longchamp wrote:
> 
> You need the patch 4/4 - platform bindings, which is not in that queue and 
> will only be merged in the next kernel version. You can so far pick it up 
> here:
> 
> http://marc.info/?l=linux-arm-kernel&m=123143901514438&w=2
> 

I have the platform bindings, the ipu-core platform_device (from patch 
4/4) is registered on my system. It's only the ipu-core platform_driver 
  (from patch 2/4) that is not registered and I don't understand why.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp@epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
