From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 18 Mar 2015 10:59:20 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150318105920.GS16501@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
 <20150318101717.GN10964@mwanda>
 <CAA5enKZTjSsfX_4XkZFjbpDchZuBDfTNaK1_5GjFFwthjFZM7Q@mail.gmail.com>
In-Reply-To: <CAA5enKZTjSsfX_4XkZFjbpDchZuBDfTNaK1_5GjFFwthjFZM7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 18, 2015 at 10:46:52AM +0000, Lorenzo Stoakes wrote:
> On 18 March 2015 at 10:17, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > Why is there a RESEND in the subject.
> 
> To avoid confusion (and Sudip explicitly mentioned there might be
> some), and in addition I had to update my patch series to take into
> account that it no longer applied due to another patch which applies
> the ANSI C function prototype fixes having already been applied.

Btw, sorry for coming down hard on you.  You're a newbie and expected to
make these mistakes.  Your patches are good and appreciated.

Call it a v2 patch.  Put a note under the --- cut off line:
v2: updated to apply to latest linux-next

http://kernelnewbies.org/PatchTipsAndTricks

regards,
dan carpenter

