From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Wed, 20 Jan 2016 21:16:43 +0000
Subject: Kill ->fb_rotate?
Message-Id: <87d1swdk90.fsf@rasmusvillemoes.dk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

it seems that the fb_rotate method in struct fb_ops is never actually
invoked, and it's been that way in the entire history of git (in fact,
the last occurrence of the string '->fb_rotate' vanished over 10 years
ago, with b4d8aea6d6). Is there any reason not to nuke the few dozen
lines of dead code in the few drivers that actually implement it and
reduce sizeof(struct fb_ops) by sizeof(void*)?

Rasmus
