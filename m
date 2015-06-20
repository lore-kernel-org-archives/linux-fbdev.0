From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 20 Jun 2015 10:59:51 +0000
Subject: Re: [PATCH 2/4] staging: sm750fb: fix spacing issues
Message-Id: <20150620104751.GC29626@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F83JesFGDeEPbcUsMHSuXjeYocZDWyjMfUON02hf3HbCg@mail.gmail.com>
 <1434790115-21683-2-git-send-email-juston.h.li@gmail.com>
In-Reply-To: <1434790115-21683-2-git-send-email-juston.h.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Sat, Jun 20, 2015 at 01:48:33AM -0700, Juston Li wrote:
> Fix spacing errors and warnings caught by checkpatch.pl
> ERROR: space prohibited after that open parenthesis '('
> ERROR: space required before the open brace '{'
> ERROR: need consistent spacing around
> ERROR: trailing whitespace
> WARNING: unnecessary whitespace before a quoted newline
these are again too many changes in a single patch. please break them
up so that each patch does a single type of change.

regards
sudip
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
