From: Kronos <kronos@people.it>
Subject: Re: radeon_pm.c locking problem
Date: Mon, 5 Jul 2004 18:41:04 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040705164104.GA14968@dreamland.darkstar.lan>
References: <40E59B82.7000807@undead.cc> <20040702185241.GA25832@dreamland.darkstar.lan> <1089035092.3014.7.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhWX0-0000RJ-L7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 09:41:26 -0700
Received: from mail-relay-4.tiscali.it ([212.123.84.94] helo=sparkfist.tiscali.it)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BhWWz-0002yK-VU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 09:41:26 -0700
Content-Disposition: inline
In-Reply-To: <1089035092.3014.7.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@people.it>, John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Mon, Jul 05, 2004 at 08:44:53AM -0500, Benjamin Herrenschmidt ha scritto: 
> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> 
> > is expanded in:
> > 
> > do {
> >         unsigned long flags;
> >         spin_lock_irqsave(&rinfo->reg_lock, flags);
> >         __OUTPLL(pllPIXCLKS_CNTL, INPLL(pllPIXCLKS_CNTL) & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
> >         spin_unlock_irqrestore(&rinfo->reg_lock, flags);
> > } while(0)
> > 
> > and INPLL will try to reacquire the lock ->reg_lock. We could either use
> > __INPLL (which does not take the lock) or make OUTPLL an inline function
> > (in this way INPLL is called before entering the function).
> 
> Make it an inline function...

Here it is:

--- linux-2.6/drivers/video/aty/radeonfb.h.orig	2004-07-05 18:27:05.000000000 +0200
+++ linux-2.6/drivers/video/aty/radeonfb.h	2004-07-05 18:38:52.000000000 +0200
@@ -393,37 +393,43 @@
 
 #define INPLL(addr)		_INPLL(rinfo, addr)
 
-#define OUTPLL(addr,val)	\
-	do {	\
-		unsigned long flags;\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); \
-		__OUTPLL(addr, val); \
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); \
-	} while(0)
-
-#define OUTPLLP(addr,val,mask)  					\
-	do {								\
-		unsigned long flags;                                    \
-		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
-		_tmp  = __INPLL(rinfo,addr);				\
-		_tmp &= (mask);						\
-		_tmp |= (val);						\
-		__OUTPLL(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
-	} while (0)
-
-#define OUTREGP(addr,val,mask)  					\
-	do {								\
-		unsigned long flags;                                    \
-		unsigned int _tmp;					\
-		spin_lock_irqsave(&rinfo->reg_lock, flags); 		\
-		_tmp = INREG(addr);				       	\
-		_tmp &= (mask);						\
-		_tmp |= (val);						\
-		OUTREG(addr, _tmp);					\
-		spin_unlock_irqrestore(&rinfo->reg_lock, flags); 	\
-	} while (0)
+static inline void _OUTPLL(struct radeonfb_info *rinfo, unsigned int addr, unsigned int val)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	__OUTPLL(addr, val);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+#define OUTPLL(addr,val)	_OUTPLL(rinfo, addr, val)
+
+static inline void _OUTPLLP(struct radeonfb_info *rinfo, unsigned int addr, unsigned int val, unsigned int mask)
+{
+	unsigned long flags;
+	unsigned int tmp;
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	tmp = __INPLL(rinfo, addr);
+	tmp &= (mask);
+	tmp |= (val);
+	__OUTPLL(addr, tmp);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+#define OUTPLLP(addr,val,mask)	_OUTPLLP(rinfo,addr,val,mask)
+
+static inline void _OUTREGP(struct radeonfb_info *rinfo, unsigned int addr, unsigned int val, unsigned int mask)
+{
+	unsigned long flags;
+	unsigned int tmp;
+	spin_lock_irqsave(&rinfo->reg_lock, flags);
+	tmp = INREG(addr);
+	tmp &= (mask);
+	tmp |= (val);
+	OUTREG(addr, tmp);
+	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
+}
+
+#define OUTREGP(addr,val,mask)	_OUTREGP(rinfo,addr,val,mask)
 
 #define MS_TO_HZ(ms)       ((ms * HZ + 999) / 1000)
 

Luca
-- 
Home: http://kronoz.cjb.net
Runtime error 6D at f000:a12f : user incompetente


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
