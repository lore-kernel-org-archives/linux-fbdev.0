From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Fbdev magics
Date: Fri, 7 May 2004 21:33:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405072133.37300.adaplas@hotpop.com>
References: <200405050027.58630.lucasvr@terra.com.br> <Pine.GSO.4.58.0405061112110.12096@waterleaf.sonytel.be> <200405070026.54372.lucasvr@gobolinux.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BM5T0-00048K-PC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 06:32:42 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BM5T0-0002XR-GN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 06:32:42 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 97EAD746BB
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  7 May 2004 12:44:23 +0000 (UTC)
In-Reply-To: <200405070026.54372.lucasvr@gobolinux.org>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Lucas Correia Villa Real <lucasvr@gobolinux.org>, linux-fbdev-devel@lists.sourceforge.net

On Friday 07 May 2004 11:26, Lucas Correia Villa Real wrote:
> On Thursday 06 May 2004 06:17, Geert Uytterhoeven wrote:
> ...

>
> I've seen some LCD display drivers for embedded devices that handled it
> directly with request_irq() on 2.4. As I could see from the bottom layers
> of fbdev, an interrupt handler in a driver doesn't seem to hurt anyone
> there.. or am I wrong?
>

Within the console, you probably can't use interrupts, at least in 2.4.x.  
However, there are patches around that uses an interrupt service especially 
with waiting for vrefresh.  I've done it with the i810fb (around 2.4.18), and 
I think matroxfb has one too.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
