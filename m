From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] pm2fb: fb_sync added
Date: Tue, 08 May 2007 20:32:27 +0800
Message-ID: <1178627547.4953.5.camel@daplas>
References: <464026127324d@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlOrx-0003YI-IY for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 05:32:41 -0700
Received: from wx-out-0506.google.com ([66.249.82.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HlOrx-00015F-9A
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 05:32:41 -0700
Received: by wx-out-0506.google.com with SMTP id i30so3057890wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 May 2007 05:32:40 -0700 (PDT)
In-Reply-To: <464026127324d@wp.pl>
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

On Tue, 2007-05-08 at 09:26 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch converts internal wait_pm2() function to fb API
> fb_sync() method.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> The change of arguments in acceleration function allows use of
> fb_sync by them. Current testing shows that fb_sync is not
> required, but I left new arguments in case it may be needed. I am
> working on speeding scrolling now.

Actually, creating an fb_sync() method would be better in terms of
maximizing the thoroughput of the GPU in comparison with indiscriminate
calls to sync waits. It would have been better if imageblit is also
hardware assisted.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
