From: Michal Januszewski <spock@gentoo.org>
Subject: Re: [PATCH v2 0/5] uvesafb: a general
	description
Date: Fri, 6 Jul 2007 21:53:43 +0200
Message-ID: <20070706195343.GA12096@spock.one.pl>
References: <20070630163101.GA3838@spock.one.pl>
	<48f7fe350707051038p422ea305w10d727bcc44e5d7b@mail.gmail.com>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I6tsF-0000jE-UY for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jul 2007 12:53:52 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I6tsE-00067n-Hr
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jul 2007 12:53:51 -0700
Content-Disposition: inline
In-Reply-To: <48f7fe350707051038p422ea305w10d727bcc44e5d7b@mail.gmail.com>
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
To: Ryan Hope <rmh3093@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, hpa@zytor.com

On Thu, Jul 05, 2007 at 01:38:46PM -0400, Ryan Hope wrote:
>  I applied
>  http://dev.gentoo.org/~spock/projects/uvesafb/archive/uvesafb-0.1-rc2-2.6.22-rc6.patchto
>  2.6.22-rc6-mm1... everything seems to be working properly. However, in dmesg
>  I did notice the following message:
> 
>  uvesafb: message too long (9872), can't execute task
>  uvesafb: VBE get state call failed (eax=0x4f04, err=-7)
> 
>  The messages seem to get generated when I switch VTs. Just thought I would
>  let you know. If there is anything else I can do to help let me know.

It looks like the VBE hardware state buffer for your video card is
larger than the 4k currently supported by connector.  The problem should
be easily fixed by setting CONNECTOR_MAX_MSG_SIZE in include/linux/connector.h
to e.g. 16k.  I've already updated the patch on my website, so next time
you download it, the error messages should be gone.

Best regards,
Michal


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
