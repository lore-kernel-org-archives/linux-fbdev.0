From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: [PATCH 0/17] Add Texas Instruments OMAP LCD
	driver-v2
Date: Tue, 26 Jun 2007 18:00:22 +0530
Message-ID: <5d5443650706260530x11b6ce8el542eabbe3800b4d6@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I3ABb-0002le-KT for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 05:30:23 -0700
Received: from wa-out-1112.google.com ([209.85.146.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I3ABb-0007qF-9b
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 05:30:23 -0700
Received: by wa-out-1112.google.com with SMTP id k22so2254918waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Jun 2007 05:30:22 -0700 (PDT)
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
To: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com
Cc: juha.yrjola@solidboot.com, akpm@linux-foundation.org, imre.deak@solidboot.com, linux-kernel@vger.kernel.org

Hi Tony,

This patch series contains Texas Instruments OMAP LCD framebuffer
drivers. This driver is divided into

* main omapfb driver, which handles most common functions across
processor series, like platform driver registration, ioctl handling,
much like fb skeleton.

This driver then gets through the callback based on the
internal/external lcd controller and panel registered to it based on
processor and board. Internal/External LCD controller as per lcd panel
data registration is being done in separate files and so does patches.

Overall this patches contains framebuffer driver for TI OMAP1
(OMAP1510/1610/1710) and OMAP2 (OMAP2420/2430) and external
controllers used in Nokia Internal Tablets (N770/N800).

These drivers were very well tested on OMAP GIT [1] tree from long
time. Most of the code for this driver is written by Imre Deak
<imre.deak@solidboot.com>.

Also CCed to LKML for wider review, and this v2 went through checkpatch.pl and
I have modified the patches to accept most of checkpatch comments.

-- 
--Trilok Soni
PS: Sorry, all the patches will be as attachment (not inline one), as
I can only use gmail webmail interface, NO pop access allowed, where I
am working.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
