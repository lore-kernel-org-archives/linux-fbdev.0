From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: inappropriate use of in_atomic()
Date: Fri, 11 Mar 2005 17:25:11 +1100
Message-ID: <20050311172511.1fa0919e.sfr@canb.auug.org.au>
References: <20050310204006.48286d17.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0337619689=="
In-Reply-To: <20050310204006.48286d17.akpm@osdl.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/cgi-bin/mailman/listinfo/linuxppc64-dev>, 
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc64-dev>
List-Post: <mailto:linuxppc64-dev@ozlabs.org>
List-Help: <mailto:linuxppc64-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/cgi-bin/mailman/listinfo/linuxppc64-dev>, 
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc64-dev-bounces@ozlabs.org
Errors-To: linuxppc64-dev-bounces@ozlabs.org
To: Andrew Morton <akpm@osdl.org>
Cc: jt@bougret.hpl.hp.com, javier@tudela.mad.ttd.net, roland@topspin.com, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net, paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net

--===============0337619689==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_Mar_2005_17_25_11_+1100_XzibCpGjg+vlEUgZ"

--Signature=_Fri__11_Mar_2005_17_25_11_+1100_XzibCpGjg+vlEUgZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

On Thu, 10 Mar 2005 20:40:06 -0800 Andrew Morton <akpm@osdl.org> wrote:
>
> in_atomic() is not a reliable indication of whether it is currently safe
> to call schedule().
>
> 	arch/ppc64/kernel/viopath.c

in_atomic() in viopath.c was just used to determine if we had initialised
enough to be able to wait in a semaphore (i.e. schedule).  Thus it can be
replaced now with checking system_state for SYSTEM_RUNNING.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Test booted on iSeries (which is the only place it is used).
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/arch/ppc64/kernel/viopath.c linus-in_atomic/arch/ppc64/kernel/viopath.c
--- linus/arch/ppc64/kernel/viopath.c	2005-01-22 06:09:01.000000000 +1100
+++ linus-in_atomic/arch/ppc64/kernel/viopath.c	2005-03-11 17:19:45.000000000 +1100
@@ -79,7 +79,7 @@ static void handleMonitorEvent(struct Hv
 /*
  * We use this structure to handle asynchronous responses.  The caller
  * blocks on the semaphore and the handler posts the semaphore.  However,
- * if in_atomic() is true in the caller, then wait_atomic is used ...
+ * if system_state is not SYSTEM_RUNNING, then wait_atomic is used ...
  */
 struct doneAllocParms_t {
 	struct semaphore *sem;
@@ -465,7 +465,7 @@ static int allocateEvents(HvLpIndex remo
 	DECLARE_MUTEX_LOCKED(Semaphore);
 	atomic_t wait_atomic;
 
-	if (in_atomic()) {
+	if (system_state != SYSTEM_RUNNING) {
 		parms.used_wait_atomic = 1;
 		atomic_set(&wait_atomic, 1);
 		parms.wait_atomic = &wait_atomic;
@@ -475,7 +475,7 @@ static int allocateEvents(HvLpIndex remo
 	}
 	mf_allocate_lp_events(remoteLp, HvLpEvent_Type_VirtualIo, 250,	/* It would be nice to put a real number here! */
 			    numEvents, &viopath_donealloc, &parms);
-	if (in_atomic()) {
+	if (system_state != SYSTEM_RUNNING) {
 		while (atomic_read(&wait_atomic))
 			mb();
 	} else

--Signature=_Fri__11_Mar_2005_17_25_11_+1100_XzibCpGjg+vlEUgZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCMTnI4CJfqux9a+8RAjn9AJ9xruaPaahKA3vcSh+xKvL+ir+3jwCfVVDO
geeW/CNzOmGS9acstKu1byY=
=k8EP
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Mar_2005_17_25_11_+1100_XzibCpGjg+vlEUgZ--

--===============0337619689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc64-dev mailing list
Linuxppc64-dev@ozlabs.org
https://ozlabs.org/cgi-bin/mailman/listinfo/linuxppc64-dev

--===============0337619689==--
