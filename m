From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 16 Mar 2015 20:54:47 +0000
Subject: Re: [PATCH] staging/sm75fb: Declare static functions as such
Message-Id: <CAPybu_0DKQnGs324ayKZ3LAnFiwQ+1+6bL7Esiu_bimuoa578A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426503069-27901-1-git-send-email-ricardo.ribalda@gmail.com> <CAA5enKbVYqaFx77T94r3t-gEF2+Y6auQheR_a6Tn45BNzt2Aqw@mail.gmail.com>
In-Reply-To: <CAA5enKbVYqaFx77T94r3t-gEF2+Y6auQheR_a6Tn45BNzt2Aqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>

Hello Lorenzo

On Mon, Mar 16, 2015 at 8:03 PM, Lorenzo Stoakes <lstoakes@gmail.com> wrote:

>
> I currently have a patch series awaiting the final ok which includes
> fixes for these warnings
> (http://lkml.iu.edu/hypermail/linux/kernel/1503.1/02535.html),
> apologies but assuming there isn't something hideously wrong with my
> series I suspect they supersedes this patch :(

Sorry about that, I did pull from linux-next and I am crealy not
subscribed to the right mailing list.


>
> It's really easy to accidentally submit a patch that has already been
> covered elsewhere; I, as a rather new kernel contributor, always find
> I have to search quite a bit to be *sure* that it's not been covered
> already.

I miss something like the properly maintained patchwork on
linux-media. It works really well to see what is on the pipeline. I
honestly never thought that somebody will take a look to this driver
:)

>
> Additionally, your subject line is 'staging/sm75fb: Declare static
> functions as such' which ought to be 'staging: sm750fb: Declare static
> functions as such' - there's a typo in the device name and I think the
> convention is always to use colons in subject lines.

About the typo, you are right of course :)

Regarding the colon, there is no convention about that, every
subsystem has its own preference. I prefer / than :

I agree that is your patch that should be pulled, not this one. But I
think you should split your patch in one patch per file.

All that said

Nacked-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

>
> Best,

Thanks!

>
> --
> Lorenzo Stoakes
> https:/ljs.io



-- 
Ricardo Ribalda
