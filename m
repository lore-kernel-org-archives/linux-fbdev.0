From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Fwd: [Dri-devel] Proposed DRI driver interface changes (all people interested in pbuffers please read!)
Date: Sat, 30 Aug 2003 10:20:39 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030830172039.64187.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19t9Oy-0002T5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Aug 2003 10:20:41 -0700
Received: from web14915.mail.yahoo.com ([216.136.225.228])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19t9Oy-0007Kh-65
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Aug 2003 10:20:40 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>


--- Ian Romanick <idr@us.ibm.com> wrote:
> From: Ian Romanick <idr@us.ibm.com>
> To: "DRI developer's list" <dri-devel@lists.sourceforge.net>
> Subject: [Dri-devel] Proposed DRI driver interface changes (all people
> interested in pbuffers
>  please read!)
> Date: Thu, 28 Aug 2003 12:44:18 -0700
> 
> I know that a lot of people in the community are very interested in 
> seeing pbuffer support in DRI drivers.  I've been quick to point out 
> that pbuffers require fbconfigs.  I've also been working to figure out 
> how to enable fbconfig support in client-side drivers.  For stand-alone 
> drivers this isn't a difficult task, but for drivers used with XFree86 
> there are a number of issues.  The remainder of this message is 
> basically divided into three parts.  In the first part I describe what 
> the problems are, and in the second part I propose some solutions.  The 
> solutions that I propose involve deprecating some fundamental DRI 
> interfaces (i.e., __driCreateScreen) and replacing them with updated 
> interfaces.  In the third section I propose how backwards compatibility 
> could be maintained with the new interfaces.
> 
> What are the problems?
> ======================
> 
> fbconfigs provide a "new" way for applications to describe the 
> parameters that are required of a context and a drawable.  fbconfigs are 
> extendible in that new extensions, such as GLX_OML_swap_method, can add 
> new attributes to an fbconfig.  Additional client / server protocol is 
> also defined.  Unlike GLX visuals, fbconfigs can also describe 
> off-screen rendering targets.  It is this element that makes fbconfigs a 
> prerequisite for pbuffers.
> 
> fbconfigs are used for creating new rendering contexts (via 
> glXCreateNewContext or glXCreateContextWithConfigSGIX).  Just like when 
> a context is created using a GLX visual, a context can be created as 
> direct or indirect.  Drawables are also created using fbconfigs (via 
> glXCreateWindow, glXCreatePixmap, glXCreatePbuffer, etc.).  When a GLX 
> drawable is created it is not know if it will be bound to a direct 
> context or an indirect context.  In fact, a given drawable could be 
> bound to both types of context at different times in its lifetime.
> 
> Because drawables can be bound to any type of context at any time, the 
> client and the server must agree on the set of available fbconfigs.  In 
> XFree86 this means that three drivers have to agree.  The client-side 
> DRI driver, the server-side DDX driver, and the server-side libGLcore.a 
> "driver" have to agree on the set of available fbconfigs.  The 
> difficulty in this is compounded by the fact that all three of these 
> drivers may differ in version.  In the future when accelerated 
> server-side rendering is supported it is quite likely that users will 
> update their client-side driver without restarting X.  This will result 
> in direct rendering contexts having a more recent driver, which may 
> support addition fbconfigs, than the server-side driver.
> 
> My initial hope what that fbconfigs could be implemented completely on 
> the client-side.  That is clearly impossible.
> 
> How can the problems be solved?
> ===============================
> 
> Several of the interfaces between libGL and the client-side DRI driver 
> need to be modified to support fbconfigs.  As an added benefit, the new 
> interfaces should be directly usable by the stand-alone drivers.  The 
> precursor is to modify __GLcontextModes to contain all of the fields, 
> though with non-X specific datatypes, that are in __GLXFBConfigRec.
> 
> The first proposed change is to deprecate __driCreateScreen and replace 
> it with __driCreateNewScreen.  There are two significant differences 
> between the old function and the new.  The old function was passed an 
> array of GLX visuals, but the new function is passed a linked list of 
> __GLconextModes.  This is convenient because whenever a GLX visual is 
> used by the client-side driver it is converted to a __GLcontextModes 
> structure first.  The list of __GLcontextModes contains only the modes 
> that directly match X visuals.  In the stand-alone driver this could be 
> a small set of generic modes that match the current display mode.
> 
> The other difference is that new modes are added to the list.  The idea 
> is that the driver adds new modes for the on-screen and off-screen 
> fbconfigs that it can support.  In the XFree86 environment, libGL would 
> then create a new list that is the intersection of the client-side 
> driver supplied list and the server-side driver supplied list.  This 
> subset is would be exposed to applications.  It is expected that until 
> server-side HW accelerated rendering is available, the server will 
> export a very rich set of possible fbconfigs (i.e., every combination of 
> buffer types & sizes that SW Mesa can support).
> 
> fbconfig IDs are not assigned by client-side drivers, and the drivers 
> should not care about the fbconfig ID values.  This allows libGL to 
> either use the server supplied fbconfig ID values in the XFree86 
> environment or assigned arbitrary fbconfig ID values in the stand-alone 
> environment.
> 
> The specifics of how, when, and by whom memory for the __GLcontextModes 
> structures are allocated and freed has not been finalized.  My current 
> thinking is that libGL should export constructor and destructor 
> functions (via glXGetProcAddress of course).  The client-side driver 
> would allocate structures as needed and fill-in the correct values.  The 
> client-side drivers would check the internal API version to determine 
> which fields were available.  As new fields are added the constructor 
> would fill in reasonable defaults to maintain backwards compatibility 
> with older client-side drivers.
> 
> The second major change is to deprecate createContext (in the 
> __DRIscreenRec) and replace it with createNewContext.  The only 
> difference in interface is the XVisualInfo parameter is replaced with a 
> __GLcontextModes parameter.  This interface would be used by libGL for 
> creating any context, whether the application used a GLX visual or an 
> fbconfig.  This is convenient because the first the thing createContext 
> does in all the open-source drivers is convert the XVisualInfo into a 
> __GLcontextModes structure!
> 
> The final major change is to deprecate createDrawable (in the 
> __DRIscreenRec), which is already unused, and replace it with 
> createNewDrawable.  Since the existing entry-point is not used, it may 
> be possible to keep the same name and the same location in the 
> structure.  The new entry-point would look something like:
> 
> 	void *(*createNewDrawable)(Display *dpy,
> 		__GLcontextModes *mode,
> 		GLXDrawable draw, __DRIdrawable *pdraw,
> 		int renderType, const int *attributes);
> 
> The meaning of dpy, mode, draw, and pdraw should be obvious.  renderType 
> is one of GLX_WINDOW_BIT, GLX_PIXMAP_BIT, or GLX_PBUFFER_BIT.  Initially 
> only GLX_WINDOW_BIT will be supported.  When DRI drivers are used on the 
> server-side, GLX_PIXMAP_BIT will have to be supported, and when pbuffer 
> support is added GLX_PBUFFER_BIT will have to be supported.  attributes 
> matches the attributes parameter of glXCreatePbuffer, glXCreateWindow, 
> and glXCreatePixmap.
> 
> How can backwards compatibility be maintained?
> ==============================================
> 
> There are two parts of the backwards compatibility equation.  There is 
> backwards compatibility between a new libGL and an old client-side 
> driver, and there is backwards compatibility between a new client-side 
> driver and an old libGL.  Both can be handled very reasonably.
> 
> It should be trivial for libGL to dynamically select which interface to 
> use.  If the client-side driver does not export the __driCreateNewScreen 
> symbol, then the old interface is used.  This also means that libGL 
> should ignore requests from the client-side driver to enable 
> SGIX_fbconfig support.  Without the new interface such support is 
> impossible.  This will prevent possible conflicts with closed-source 
> drivers that are expecting a different libGL.
> 
> In the client-side driver it should be possible to rip out all support 
> for the old interfaces from the device specific code (i.e., the code in 
> lib/GL/mesa/src/drv).  The DRI utility code (in lib/GL/dri) could easily 
> create wrappers for the old createContext interface and the old 
> __driCreateScreen interface.  The __driCreateScreen interface would 
> simply convert the list of visuals to a list of __GLcontextModes and 
> pass it to __driCreateNewScreen.  The createContext wrapper would 
> operate in a similar fashion.
> 
> Where to now?
> =============
> 
> I'd like to discuss some of these interfaces changes, but I hope that 
> none of them are too controversial.  The sooner we can agree on a set of 
> changes, the sooner they can be put into action.  My hope is that 
> support for fbconfigs, at the very least, will be complete and well 
> enough tested to make it into the next XFree86 release.  Since no date 
> (or version number AFAIK) has been set yet, our chances seem good.
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
