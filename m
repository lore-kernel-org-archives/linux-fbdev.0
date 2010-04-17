From: Jonathan Corbet <corbet@lwn.net>
Date: Sat, 17 Apr 2010 20:40:08 +0000
Subject: Re: [PATCH 1/7] viafb: package often used basic io functions
Message-Id: <20100417144008.2bdd49f9@bike.lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271533498-3376-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1271533498-3376-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

On Sat, 17 Apr 2010 19:44:51 +0000
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> This patch puts redesigned versions of the basic io functions that
> are used overall the driver in an extra header.

I don't object to the basic idea of these patches, but...as I'm sure
you can imagine, this stuff will conflict hard with the work I'm trying
to prepare for submission.  I, too, have had to go in to those
functions and do things like add locking.  Is there any chance you
could hold off for just a *little* bit while I get things together?  

As I said before, I was traveling this last week.  Now I'm home and can
get back to this...

Thanks,

jon
