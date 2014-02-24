From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 24 Feb 2014 10:42:07 +0000
Subject: Re: [PATCH v2 2/5] vmbus: add missing breaks
Message-Id: <20140224104207.GG26722@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393237516-28545-1-git-send-email-kraxel@redhat.com>
 <1393237516-28545-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1393237516-28545-3-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, jasowang@redhat.com, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, "open list:Hyper-V CORE AND..." <devel@linuxdriverproject.org>, haiyangz@microsoft.com

I'm sorry, I know it sucks to not get credit for fixes, but please just
fold this into [patch 1/5].  We really should have a tag for this kind
of thing.

Would something like this work?
Additional-Fixes: Gerd Hoffmann <kraxel@redhat.com>

regards,
dan carpenter


