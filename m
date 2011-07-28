From: Francis Moreau <francis.moro@gmail.com>
Date: Thu, 28 Jul 2011 22:10:36 +0000
Subject: Re: [PATCH] fb: avoid possible deadlock caused by fb_set_suspend
Message-Id: <CAC9WiBidzYhuZMDS4VZpE7cTUdF0_NcAXFwEfCduKzge1CA4mw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4DF7B0B4.4060002@gmx.de>
	<1308337359-3480-1-git-send-email-FlorianSchandinat@gmx.de>
	<4E271B72.3070909@gmx.de>
In-Reply-To: <4E271B72.3070909@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: lethal@linux-sh.org, linux-fbdev@vger.kernel.org, torvalds@linux-foundation.org, bonbons@linux-vserver.org, linux-kernel@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, stable@kernel.org

On Wed, Jul 20, 2011 at 8:16 PM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> what are your plans for the patch below? Do you queue it for 3.1?

Looks like someone else fixed it slightly differently:

http://permalink.gmane.org/gmane.linux.kernel.stable/15187

-- 
Francis
