From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: prevent spurious recompilations
Date: Wed, 12 Oct 2005 06:59:02 +1000
Message-ID: <1129064342.17365.213.camel@gaston>
References: <20051011215507.64e8aa40.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPRJ7-0002Dx-KI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 Oct 2005 14:05:09 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EPRJ3-0005aG-6P
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 Oct 2005 14:05:09 -0700
In-Reply-To: <20051011215507.64e8aa40.khali@linux-fr.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, 2005-10-11 at 21:55 +0200, Jean Delvare wrote:
> Hi Ben, all,
> 
> I'm doing frequent changes to the i2c header files, and noticed that
> the radeonfb driver was recompiled each time I do, although I did not
> include the I2C/DDC support. This is due to i2c header files being
> included when they are not needed. Here is a patch fixing the problem.
> Please consider applying it.

I generally quite dislike such #ifdef clutter ... 

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
