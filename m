From: Javier Villavicencio <jvillavicencio@arnet.com.ar>
Subject: Re: Re: New FBDev patch (a little report)
Date: Sat, 10 Jan 2004 14:15:40 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040110141540.0f4e3204.jvillavicencio@arnet.com.ar>
References: <20040108231217.GB7085@louise.pinerecords.com>
	<Pine.LNX.4.44.0401090035080.17957-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfMi9-0003Pz-DN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jan 2004 09:15:45 -0800
Received: from [63.246.134.60] (helo=refusespam.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AfMi9-0004n6-0C
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jan 2004 09:15:45 -0800
In-Reply-To: <Pine.LNX.4.44.0401090035080.17957-100000@phoenix.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>

Hi, I've tested this patch (after the radeon patch update), and it's working
almost perfect with just one problem: going back from X the framebuffer
screen is completely distorted, but it can be corrected changing the depth
with fbset (-depth 8/16/32 and back to the working depth).
I have a radeon 9600 (or RV350 AP) and of course the -current- 2.6.x
driver doesn't include this PCI_ID in the code, so it "shouldn't work", but
I've added (from 2.4) the PCI_ID and some code to recognize/setup the
rv350 and the current 2.6.x driver -just- worked, I cannot use fbset to
set resolutions/depths, because it screws up the whole framebuffer. But
going back from X and to X works ok if I don't touch the framebuffer with
fbset. This is with my modified verison of the 2.6.x old driver.
IIRC there was a mail about the binary driver from ATI touching something
hidden in the chip and that I think may be the cause of this "distortion" when
switching from and to X (yes, sometimes X screws up when switching from
framebuffer, but running any GL app corrects everything in X, ej: glxgears).
So the strange thing about this is the old driver working "almost" correctly
with the binary X drivers from ATI and the new driver working flawless in 
console but destroying completely the state of the card when switching
to/from X (and of course X using binary ATI drivers).

Salu2.
Javier Villavicencio.

On Fri, 9 Jan 2004 00:35:20 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> 
> 
> Try it again. I missed a patch for the radeon.
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Perforce Software.
> Perforce is the Fast Software Configuration Management System offering
> advanced branching capabilities and atomic changes on 50+ platforms.
> Free Eval! http://www.perforce.com/perforce/loadprog.html
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
