From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New FBDev patch (a little report)
Date: Sun, 11 Jan 2004 18:35:57 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073806556.765.103.camel@gaston>
References: <20040108231217.GB7085@louise.pinerecords.com>
	 <Pine.LNX.4.44.0401090035080.17957-100000@phoenix.infradead.org>
	 <20040110141540.0f4e3204.jvillavicencio@arnet.com.ar>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfaDB-0001W2-88
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jan 2004 23:40:41 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AfaD6-0007Cm-RW
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Jan 2004 23:40:37 -0800
In-Reply-To: <20040110141540.0f4e3204.jvillavicencio@arnet.com.ar>
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
To: Javier Villavicencio <jvillavicencio@arnet.com.ar>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Sun, 2004-01-11 at 04:15, Javier Villavicencio wrote:
> Hi, I've tested this patch (after the radeon patch update), and it's working
> almost perfect with just one problem: going back from X the framebuffer
> screen is completely distorted, but it can be corrected changing the depth
> with fbset (-depth 8/16/32 and back to the working depth).

We need to add a callback to the fbdev when restoring the console
from KD_GRAPHICS to KD_TEXT, maybe a special case of "switch".

James, I suggest turning that into a set_par call with a flag for
'forcing' the mode to be re-applied fully even if it already matches
the HW. (Currently, set_par in some drivers like my new radeonfb,
for obvious perfs reasons, will not touch the HW if the var and the
par are matching already).

Ben.
 



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
