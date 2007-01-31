From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 2/10] ps3: AV Settings Driver Library
Date: Wed, 31 Jan 2007 08:34:56 -0800
Message-ID: <45C0C530.4040407@am.sony.com>
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701301800020.29487@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCIQV-0000uR-26 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 08:35:15 -0800
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]
	helo=outbound2-cpk-R.bigfish.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HCIQQ-0006WI-TC
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 08:35:14 -0800
In-Reply-To: <Pine.LNX.4.62.0701301800020.29487@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

Geert Uytterhoeven wrote:
> Add the PS3 AV Settings Driver Library.
> 
> The AV Settings driver is used to control Audio and Video settings.
> It communicates with the policy manager through the virtual uart.
> 
...  
> +config PS3_PS3AV
> +	tristate "PS3 AV settings driver library"
> +	select PS3_VUART
> +	default y
> +	help
> +	  Include support for the PS3 Platform AV Settings driver library.

Sorry for not saying something before, but I really don't like calling this
a library.  It is modeled as a driver, shows up as a device/driver pair under
/sys/bus/ps3_vuart/, and services a vuart port device.  It should also be fixed
to work as a lodable module.  I think calling it a driver much better
communicates how it fits into the device model.

-Geoff


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
