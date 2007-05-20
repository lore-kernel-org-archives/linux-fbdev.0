From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] pm2fb: white spaces clean up
Date: Sun, 20 May 2007 20:01:18 +0800
Message-ID: <1179662478.15182.1.camel@daplas>
References: <46508634.9030000@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hpk6S-0002Gy-5i for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 May 2007 05:01:38 -0700
Received: from nz-out-0506.google.com ([64.233.162.234])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hpk6R-0005hE-EM
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 May 2007 05:01:35 -0700
Received: by nz-out-0506.google.com with SMTP id i11so3017644nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 20 May 2007 05:01:34 -0700 (PDT)
In-Reply-To: <46508634.9030000@wp.pl>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sun, 2007-05-20 at 19:32 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patches kills spaces before tabs, spaces and tabs at line ends and replaces multiple 
> spaces with tabs.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

I'm getting this:

patching file drivers/video/pm2fb.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 58.
Hunk #3 FAILED at 82.
Hunk #4 FAILED at 95.
Hunk #5 FAILED at 166.
Hunk #6 FAILED at 182.
Hunk #7 FAILED at 367.
Hunk #8 FAILED at 535.
Hunk #9 FAILED at 574.
Hunk #10 FAILED at 615.
Hunk #11 FAILED at 672.
Hunk #12 FAILED at 709.
Hunk #13 FAILED at 722.
Hunk #14 FAILED at 737.
Hunk #15 FAILED at 778.
Hunk #16 FAILED at 847.
Hunk #17 FAILED at 916.
Hunk #18 FAILED at 940.
Hunk #19 FAILED at 956.
Hunk #20 FAILED at 980.
Hunk #21 FAILED at 1234.
Hunk #22 FAILED at 1317.
Hunk #23 FAILED at 1348.
Hunk #24 FAILED at 1374.
Hunk #25 FAILED at 1402.
Hunk #26 FAILED at 1423.
26 out of 26 hunks FAILED -- saving rejects to file
drivers/video/pm2fb.c.rej

Let's just wait for the next mm release and rebase from that.
(I usually strip white space from patches before sending to akpm, maybe
that's the reason).

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
