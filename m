From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 06:04:56 +0000
Subject: Re: [PATCH] Staging: sm750fb: Fix C99 Comments
Message-Id: <CAFow2F_nWCAYJHUvx4faR3zvWTikZmKSdd53=4aJjmYCQHW2mA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150620052517.GA17104@amitoj-Inspiron-3542>
In-Reply-To: <20150620052517.GA17104@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Fri, Jun 19, 2015 at 10:25 PM, Amitoj Kaur Chawla
<amitoj1606@gmail.com> wrote:
> Used C89 instead of C99 Comments and removed C99 comments performing
> prints only.
> Problem found using checkpatch.pl
>
> ERROR: do not use C99 // comments
>
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>

These changes have already been added in the staging-next tree included in
commit 'staging: sm750fb: fix c99 comments'

You should base future changes against gregkh staging-testing branch.

Regards
Juston
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
