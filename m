From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 18 Mar 2015 19:09:28 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <CAA5enKYkzLUB=OtSXU7N+R0F4qCN4B7otDci=OCR+MzxhCFSqg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
 <20150318101717.GN10964@mwanda> <CAA5enKZTjSsfX_4XkZFjbpDchZuBDfTNaK1_5GjFFwthjFZM7Q@mail.gmail.com>
 <20150318105920.GS16501@mwanda>
In-Reply-To: <20150318105920.GS16501@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 18 March 2015 at 10:59, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Call it a v2 patch.  Put a note under the --- cut off line:
> v2: updated to apply to latest linux-next
>
> http://kernelnewbies.org/PatchTipsAndTricks

Since each changed patch in the resend already incorporates changes to
update to apply to the latest linux-next, I instead referenced
whitespace/description changes (let me know if this isn't usually
something you'd reference) to avoid confusion, as otherwise I'd have
to resend other patches unchanged with just a v2 applied, then
additionally update the ones that need changes.

Let me know if you'd like this done differently!

Best,

-- 
Lorenzo Stoakes
https:/ljs.io
