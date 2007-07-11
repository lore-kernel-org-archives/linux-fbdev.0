From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [GEODE] Add framebuffer support for the	AMD
	Geode LX
Date: Thu, 12 Jul 2007 04:51:17 +0800
Message-ID: <1184187077.4504.11.camel@daplas>
References: <20070709173211.GA6157@cosmic.amd.com>
	<20070710175039.GB32055@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8j9j-0004jw-2N for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jul 2007 13:51:29 -0700
Received: from nz-out-0506.google.com ([64.233.162.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8j9h-0000Fq-8X
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jul 2007 13:51:26 -0700
Received: by nz-out-0506.google.com with SMTP id f1so4006449nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 11 Jul 2007 13:51:24 -0700 (PDT)
In-Reply-To: <20070710175039.GB32055@localhost.localdomain>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jordan Crouse <jordan.crouse@amd.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, info-linux@geode.amd.com

On Tue, 2007-07-10 at 19:50 +0200, Ondrej Zajicek wrote:
> On Mon, Jul 09, 2007 at 11:32:11AM -0600, Jordan Crouse wrote:

> If don't support panning, it should ensure that
> xres_virtual == xres and yres_virtual == yres
> 

There is no rule for this, but the above suggestion is preferred.

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
