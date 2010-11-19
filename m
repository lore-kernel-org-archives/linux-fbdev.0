From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 19 Nov 2010 23:19:49 +0000
Subject: Re: abs() vs. abs64() (was: Re: [PATCH] fbdev: fix nearest mode
Message-Id: <20101119151949.b7e514f7.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimYDAJr9x00sjGGnDF2vOVXU12qmbnmfuzA5_0h@mail.gmail.com>
	<20101119140721.33576c61.akpm@linux-foundation.org>
	<20101119222823.GA28797@quadria>
	<20101119150411.81092e94.akpm@linux-foundation.org>
In-Reply-To: <20101119150411.81092e94.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: michalj@gmail.com, Geert Uytterhoeven <geert@linux-m68k.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Fri, 19 Nov 2010 15:04:11 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> > Looks good to me.  I posted essentially the same thing some 3 months ago
> > (http://marc.info/?l=linux-kernel&m8033094822201&w=2) but it then
> > failed to get any traction.  At any rate, I like your version better as
> > it seems more readable.
> > 
> 
> I spose we should document it.   Does this look complete and accurate?
> 
> --- a/include/linux/kernel.h~include-linux-kernelh-abs-fix-handling-of-32-bit-unsigneds-on-64-bit-fix
> +++ a/include/linux/kernel.h
> @@ -143,6 +143,13 @@ extern int _cond_resched(void);
>  
>  #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
>  
> +/*
> + * abs() handles unsigned and signed longs, ints, shorts and chars.  For long
> + * types it returns a signed long.  For int, short and char types it returns a
> + * signed int.
> + * abs() should not be used for 64-bit types (s64, u64, long long) - use abs64()
> + * for those.
> + */
>  #define abs(x) ({						\
>  		long ret;					\
>  		if (sizeof(x) = sizeof(long)) {		\

Well that was a load of bollocks.  2nd attempt:

--- a/include/linux/kernel.h~include-linux-kernelh-abs-fix-handling-of-32-bit-unsigneds-on-64-bit-fix
+++ a/include/linux/kernel.h
@@ -143,6 +143,12 @@ extern int _cond_resched(void);
 
 #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 
+/*
+ * abs() handles unsigned and signed longs, ints, shorts and chars.  For all
+ * input types abs() returns a signed long.
+ * abs() should not be used for 64-bit types (s64, u64, long long) - use abs64()
+ * for those.
+ */
 #define abs(x) ({						\
 		long ret;					\
 		if (sizeof(x) = sizeof(long)) {		\
_

