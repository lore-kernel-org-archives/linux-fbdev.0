From: Jim Hague <jim.hague@acm.org>
Subject: Re: pm2fb fixes
Date: Wed, 21 Apr 2004 11:14:42 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040421111442.jim.hague@acm.org>
References: <20040421015118.2caa6e99@zerocool>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGEkq-0006hP-8j
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 03:14:56 -0700
Received: from cpc3-oxfd2-6-0-cust100.oxfd.cable.ntl.com ([81.103.193.100] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGEkp-0002oO-Qj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 03:14:56 -0700
In-Reply-To: <20040421015118.2caa6e99@zerocool>
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
To: Marcelo Ramos <mramos@montevideo.com.uy>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 21-Apr-2004 Marcelo Ramos wrote:
>> This patch fixes this bug, and a silly problem in pm2fb_blank(). There's
>> also some minor tidying.
> 
> I applied the patch and now the kernel oops is gone. How can I change the
> resolution? If I don't specify the mode then i get 640x480-60 but if i use
> video=pm2fb:mode:1024x768 (or any other resolution) I get 640x400-70. am I
> passing the driver the argument with a wrong format?

The 2.6 version of pm2fb currently only has three possible arguments, 'mode',
'lowvsync' and 'lowhsync'. I think I'm the only person needing the last two.

When compiled in to the kernel, the argument syntax imitates other 2.6 drivers.
Arguments are comma separated, and any argument that isn't 'lowvsync' or
'lowhsync' is assumed to be a modedb specification,'<hres>x<vres>-<refresh>'.
You probably want:

video=pm2fb:1024x768-70

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
