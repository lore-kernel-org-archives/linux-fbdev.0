From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: allow fbdev primary video code
	on 64-bit.
Date: Thu, 07 Jan 2010 15:06:31 -0800
Message-ID: <4B4668F7.1000304__7603.2176650644$1262909172$gmane$org@zytor.com>
References: <1262847894-27498-1-git-send-email-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hpa@zytor.com>) id 1NT2LL-0004i6-FU
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Jan 2010 00:04:43 +0000
Received: from terminus.zytor.com ([198.137.202.10])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NT2LF-0000tR-MZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Jan 2010 00:04:43 +0000
In-Reply-To: <1262847894-27498-1-git-send-email-airlied@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sf.net

On 01/06/2010 11:04 PM, Dave Airlie wrote:
> From: Dave Airlie <airlied@redhat.com>
> 
> For some reason the 64-bit tree was doing this differently and
> I can't see why it would need to.
> 
> This correct behaviour when you have two GPUs plugged in and
> 32-bit put the console in one place and 64-bit in another.
> 
> Signed-off-by: Dave Airlie <airlied@redhat.com>

Looks good... I presume this is for .34, though?

	-hpa

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
