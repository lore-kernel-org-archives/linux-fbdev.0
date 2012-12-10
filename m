From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 10 Dec 2012 12:51:33 +0000
Subject: Re: [PATCH 3/3] atmel_lcdfb: remove unsupported 15-bpp mode
Message-Id: <87obi2rrxm.fsf@dell.be.48ers.dk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355142530-10366-1-git-send-email-jhovold@gmail.com>
 <1355142530-10366-4-git-send-email-jhovold@gmail.com>
In-Reply-To: <1355142530-10366-4-git-send-email-jhovold@gmail.com> (Johan
 Hovold's message of "Mon, 10 Dec 2012 13:28:50 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>>>>> "Johan" = Johan Hovold <jhovold@gmail.com> writes:

 Johan> Since commit 787f9fd23283 ("atmel_lcdfb: support 16bit BGR:565 mode,
 Johan> remove unsupported 15bit modes") atmel_lcdfb_check_var does not accept
 Johan> 15-bpp mode so remove it from atmel_lcdfb_set_par as well.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
