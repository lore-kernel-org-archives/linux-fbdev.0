From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: tty-related oops in latest kernel(s)?
Date: Thu, 31 May 2007 07:28:42 +0800
Message-ID: <1180567722.4570.22.camel@daplas>
References: <20070530090945.ab9d51d9.akpm@linux-foundation.org>
	<20070530180428.GA5731@martell.zuzino.mipt.ru>
	<1180566886.4570.14.camel@daplas>
	<20070530.161811.108115564.davem@davemloft.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtXb6-0008It-3D for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 May 2007 16:28:56 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtXb4-00024I-NC
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 May 2007 16:28:55 -0700
Received: by py-out-1112.google.com with SMTP id u77so4233088pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 30 May 2007 16:28:49 -0700 (PDT)
In-Reply-To: <20070530.161811.108115564.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi, teanropo@jyu.fi, apw@shadowen.org, akpm@linux-foundation.org, adobriyan@gmail.com, alan@lxorguk.ukuu.org.uk

On Wed, 2007-05-30 at 16:18 -0700, David Miller wrote:
> From: "Antonino A. Daplas" <adaplas@gmail.com>
> Date: Thu, 31 May 2007 07:14:46 +0800
> 
> > Yes, 256 is too many. the pseudo_palette is used for the 16-color
> > console only.
> 
> Many many drivers allocate 256 entries, just FYI :-)  They
> all should be fixed up I guess.

I did a pseudo_palette allocation audit before, it might be high time to
run one again :-(

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
