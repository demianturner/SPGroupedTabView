//
//  TwoTieredTabViewAppDelegate.m
//  TwoTieredTabView
//
//  Created by Philip Dow on 5/28/11.
//  Copyright 2011 Philip Dow / Sprouted. All rights reserved.
//	phil@phildow.net / phil@getsprouted.com
//

/*
 Redistribution and use in source and binary forms, with or without modification, are permitted
 provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions
 and the following disclaimer in the documentation and/or other materials provided with the
 distribution.
 
 * Neither the name of the author nor the names of its contributors may be used to endorse or
 promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
 WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

// Basically, you can use the code in your free, commercial, private and public projects
// as long as you include the above notice and attribute the code to Philip Dow / Sprouted
// If you use this code in an app send me a note. I'd love to know how the code is used.

// Icons by Joseph Wain / glyphish.com

#import "AppDelegate.h"
#import "SPGroupedTabView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
}

- (void)awakeFromNib {
	
	// A NOTE ON USAGE:
	
	// SPGroupedTabView is understood to be a static rather than dynamic view. Although
	// the main content area will regularly change, the groups and tabs will generally
	// not. The view was designed with the expectation that the group and tab items
	// will be specified once and then remain for the most part unchanged.
	
	// This also means that the view is expected to remain a fixed size. There is currently
	// no support for "extended" group and tab elements, or additional groups and tabs
	// that are not currently visible but can be selected via menu, as is the case with
	// tabbed browsing in modern web browers. If you view is resized so that there is no
	// longer enough space to display all the groups or all the tabs in a group, the
	// items at the right edge will either clip or simply fall of the view.
    
	NSInteger i;
	
	_viewControllers = [[NSMutableArray alloc] init];
	
	_dataModel = [[NSArray alloc] initWithObjects:
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [NSArray arrayWithObjects:nil], @"tabs",
                   [NSImage imageNamed:@"states.png"], @"image",
                   @"Home", @"title",
                   nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [NSArray arrayWithObjects:@"People", @"Family", @"Sources", @"Repositories", nil], @"tabs",
                   [NSImage imageNamed:@"city.png"], @"image",
                   @"Tree", @"title",
                   nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [NSArray arrayWithObjects:@"Smart Matches", @"Record Matches", nil], @"tabs",
                   [NSImage imageNamed:@"tower.png"], @"image",
                   @"Matches", @"title",
                   nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [NSArray arrayWithObjects:@"Items", @"Albums", nil], @"tabs",
                   [NSImage imageNamed:@"planet.png"], @"image",
                   @"Media", @"title",
                   nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [NSArray arrayWithObjects:nil], @"tabs",
                   [NSImage imageNamed:@"tower.png"], @"image",
                   @"Places", @"title",
                   nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [NSArray arrayWithObjects:@"Common Charts", @"Chart Wizard", nil], @"tabs",
                   [NSImage imageNamed:@"tower.png"], @"image",
                   @"Charts", @"title",
                   nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [NSArray arrayWithObjects:@"Common Reports", @"Saved Reports", @"Custom Reports", nil], @"tabs",
                   [NSImage imageNamed:@"tower.png"], @"image",
                   @"Reports", @"title",
                   nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:
                   [NSArray arrayWithObjects:@"Consistency", @"Tasks", @"DNA", nil], @"tabs",
                   [NSImage imageNamed:@"tower.png"], @"image",
                   @"Manage", @"title",
                   nil],
                  nil];
	
	// sync the matrix to the model
	
	for ( i = 0; i < [self.dataModel count]; i++ )
		[[self.groupMatrix cellAtRow:0 column:i] setTitle:[[self.dataModel objectAtIndex:i] objectForKey:@"title"]];
	
	for ( i = 0; i < 4; i++ )
		[[self.tabMatrix cellAtRow:0 column:i] setTitle:@"-"];
	
	for ( i = 0; i < [[[self.dataModel objectAtIndex:0] objectForKey:@"tabs"] count]; i++ )
		[[self.tabMatrix cellAtRow:0 column:i] setTitle:[[[self.dataModel objectAtIndex:0] objectForKey:@"tabs"] objectAtIndex:i]];
	
	
	self.groupedTabView.groupMargin = 40.0;
    
    // describes the minimum amount of empty space that will be preserved to the
    // left and right of the first and last group items
    
	self.groupedTabView.highlightGroupIcons = YES;
	
    // highlightGroupIcons is NO by default. If you are providing full color images
    // you should leave it that way. But if you are providing image masks, you
    // might set this value to YES to have your image maks given a pleasant gradient
	
	self.groupedTabView.preservesSelection = YES;
    
    // by default this value is NO and the view resets the tab selection to the
    // first item whenever a different group is selected. When this value is true
    // the view will try to restore the last selected tab for each group
	
	[self.groupedTabView reloadData];
	
    // call this method when the data model is ready to load or when you have
    // changed it and want to update the content of the grouped tab view. It
    // is recommended you call this method prior to setting the group and tab
    // selections
	
	self.groupedTabView.selectedGroupIndexes = [NSIndexSet indexSetWithIndex:0];
	self.groupedTabView.selectedTabIndexes = [NSIndexSet indexSetWithIndex:0];
	
    // the grouped tab view assumes that there is at least one group and one
    // tab and that a group and tab are always selected
    
	// [groupedTabView reloadData];
    
    // It is worth noting what happens if you call reloadData after setting the group
    // and tab selectionIndexes, contrary to the recommended practice. You may comment
    // out the prior call and uncomment this one.
    
    // The view still loads, but because we are updating the content view in the
    // delegate methods, and the delegate methods are only called when we set the
    // selection and not when we reload the data, our content view is initially
    // empty.
    
    // Depending on how you provide content to the view, the order in which you load
    // the data and set the tab and group selections may or may not affect the view
    // content.
    
    // You might also comment out both calls to reloadData just to see what happens:
    // the view shows up but without errors or exceptions but with no groups, tabs or
    // content.
	
	// other
	
    //	[self.planetsView setTextContainerInset:NSMakeSize(5,20)];
}

#pragma mark -
#pragma mark Grouped Tab View Data Source

/* You must implement these two methods */

- (NSUInteger) numberOfGroupsInGroupedTabView:(SPGroupedTabView*)aTabView {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	return [self.dataModel count];
}

- (NSUInteger) numberOfTabsInGroupedTabView:(SPGroupedTabView*)aTabView group:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	return [[[self.dataModel objectAtIndex:groupIndex] objectForKey:@"tabs"] count];
}

#pragma mark -

/* It is not necessary to implement either of the following objectValue methods */

// If you do, you must return an object that is key-value reading compliant
// for the keys "title" and "image" if it is a group and the key "title"
// if it is a tab.

- (id) groupedTabView:(SPGroupedTabView*)aTabView objectValueForGroup:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	
	// our example data model group array is composed of dictionaries with "title" and "image"
	// values for each group item, so we can just return the dictionary itself and it ensures
	// that valueForKey: is converted to objectForKey:
	
	return [self.dataModel objectAtIndex:groupIndex];
}

- (id) groupedTabView:(SPGroupedTabView*)aTabView objectValueForTab:(NSUInteger)tabIndex group:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	return nil;
}

/* You must implement one of the following methods */

/*
 - (id) groupedTabView:(SPGroupedTabView*)aTabView viewForTab:(NSUInteger)tabIndex group:(NSUInteger)groupIndex {
 NSLog(@"**** %s ****",__PRETTY_FUNCTION__);
 
 // In this example, we use a separate view for each group which is shared among the tabs
 // in that group. The view is then updated in the didSelectTab delegate method.
 
 // You could also share a single view among all of the group and tab items, or provide
 // a unique view for every group / tab combination
 
 switch ( groupIndex ) {
 case 0: // states
 return self.statesView;
 break;
 case 1: // cities
 return self.citiesView;
 break;
 case 2: // example
 return self.exampleView;
 break;
 case 3: // planets
 return [self.planetsView enclosingScrollView];
 break;
 default:
 return nil;
 break;
 }
 }
 */

- (id) groupedTabView:(SPGroupedTabView*)aTabView viewControllerForTab:(NSUInteger)tabIndex group:(NSUInteger)groupIndex {
	
	// Same pattern as if we were using regular views
	
	// Whenever I load a group view controller for the first time, I save it in the
	// local viewControllers array. I always check for the existing view controller
	// before loading it again.
	
	// So we're saving the view controllers here, which would have the effect of
	// preserving state information if we weren't always resetting the content in
	// the tab delegate method.
    
	// It isn't necessary to save the view controllers locally. If you just want the
	// view controllers to be one-off, the group tab view retains them as they are
	// returned from this method and releases them when provided with new controllers
	
	NSString *desiredIdentifier = [[self.dataModel objectAtIndex:groupIndex] objectForKey:@"title"];
	NSViewController *theController = nil;
	
	if ( desiredIdentifier == nil ) return nil;
	
	for ( NSViewController *aController in self.viewControllers ) {
		if ( [(NSString*)[aController representedObject] isEqualToString:desiredIdentifier] ) {
			theController = aController;
			break;
		}
	}
	
	if ( theController == nil )  {
		
        //		NSString *nibName = [NSString stringWithFormat:@"%@Content", desiredIdentifier];
		NSString *nibName = [NSString stringWithFormat:@"%@Content", @"Example"];
		theController = [[NSViewController alloc] initWithNibName:nibName bundle:nil];
		[theController setRepresentedObject:desiredIdentifier];
		[self.viewControllers addObject:theController];
		
		// Note that I am overriding local view outlets to correspond to the view controller's
		// content view. Don't do this! It's just an easy cheat that serves the example code
		
        //		if ( [desiredIdentifier isEqualToString:@"example"] )
        //			self.exampleView = (WebView*)[theController view];
        //		else if ( [desiredIdentifier isEqualToString:@"States"] )
        //			self.statesView = (NSImageView*)[theController view];
        //		else if ( [desiredIdentifier isEqualToString:@"Cities"] )
        //			self.citiesView = (NSTextField*)[theController view];
        //		else if ( [desiredIdentifier isEqualToString:@"Planets"] ) {
        //			self.planetsView = (NSTextView*)[(NSScrollView*)[theController view] documentView];
        //			[self.planetsView setTextContainerInset:NSMakeSize(5,20)];
        //		}
        
        self.exampleView = (WebView*)[theController view];
	}
	
	return theController;
}


#pragma mark -
#pragma mark Grouped Tab View Delegate

/* If you do not implement the objectValue delegate methods, you  should implement these two methods
 - or nothing will show up */

- (void) groupedTabView:(SPGroupedTabView *)aTabView willDisplayCell:(id)aCell forGroup:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	
	// For this example I have commented out the following two methods in order to show
	// that you can instead return an object value in the corresponding data source method
	
	//[aCell setTitle:[[dataModel objectAtIndex:groupIndex] objectForKey:@"title"]];
	//[aCell setImage:[[dataModel objectAtIndex:groupIndex] objectForKey:@"image"]];
}

- (void) groupedTabView:(SPGroupedTabView*)aTabView willDisplayCell:(id)aCell forTab:(NSUInteger)tabIndex group:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	
	[aCell setTitle:[[[_dataModel objectAtIndex:groupIndex] objectForKey:@"tabs"] objectAtIndex:tabIndex]];
}

#pragma mark -

/* The rest of the methods are optional */

- (BOOL) groupedTabView:(SPGroupedTabView*)aTabView shouldSelectGroup:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	return YES;
}

- (void) groupedTabView:(SPGroupedTabView*)aTabView willSelectGroup:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void) groupedTabView:(SPGroupedTabView*)aTabView didSelectGroup:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	
	NSInteger i;
	
	[self.groupMatrix selectCellAtRow:0 column:groupIndex];
	
	for ( i = 0; i < 4; i++ )
		[[self.tabMatrix cellAtRow:0 column:i] setTitle:@""];
	
	for ( i = 0; i < [[[_dataModel objectAtIndex:groupIndex] objectForKey:@"tabs"] count]; i++ )
		[[self.tabMatrix cellAtRow:0 column:i] setTitle:[[[_dataModel objectAtIndex:groupIndex] objectForKey:@"tabs"] objectAtIndex:i]];
    
}

#pragma mark -

- (BOOL) groupedTabView:(SPGroupedTabView*)aTabView shouldSelectTab:(NSUInteger)tabIndex group:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	return YES;
}

- (void) groupedTabView:(SPGroupedTabView*)aTabView willSelectTab:(NSUInteger)tabIndex group:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void) groupedTabView:(SPGroupedTabView*)aTabView didSelectTab:(NSUInteger)tabIndex group:(NSUInteger)groupIndex {
	//NSLog(@"%s",__PRETTY_FUNCTION__);
	
	[self.tabMatrix selectCellAtRow:0 column:tabIndex];
	
	// Our example uses unique views for each group but then updates what is displayed
	// in that view whenever the tab selection changes. Normally you would rely on
	// your data model to provide the appropriate content.
	
	NSString *searchString = nil;
    NSString *googleString = nil;
	
	switch ( groupIndex ) {
		case 0: // home
			
			googleString = [NSString stringWithFormat:@"http://news.google.com/news/search?aq=f&pz=1&cf=all&ned=us&hl=en&q=%@&btnmeta_news_search=Search+News",@"myheritage"];
			[[self.exampleView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:googleString]]];
			
			break;
            
		case 1: //tree
			switch ( tabIndex ) {
				case 0:
					searchString = @"people";
					break;
				case 1:
					searchString = @"family";
					break;
				case 2:
					searchString = @"sources";
					break;
				case 3:
					searchString = @"repositories";
					break;
				default:
					searchString = @"";
					break;
			}
			
			googleString = [NSString stringWithFormat:@"http://news.google.com/news/search?aq=f&pz=1&cf=all&ned=us&hl=en&q=%@&btnmeta_news_search=Search+News", [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			[[self.exampleView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:googleString]]];
			
			break;
            
		case 2: //matches
			switch ( tabIndex ) {
				case 0:
					searchString = @"smart matches";
					break;
				case 1:
					searchString = @"record matches";
					break;
				default:
					searchString = @"";
					break;
			}
			
			googleString = [NSString stringWithFormat:@"http://news.google.com/news/search?aq=f&pz=1&cf=all&ned=us&hl=en&q=%@&btnmeta_news_search=Search+News", [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			[[self.exampleView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:googleString]]];
            
			break;
            
		case 3: //media
			switch ( tabIndex ) {
				case 0:
					searchString = @"items";
					break;
				case 1:
					searchString = @"albums";
					break;
				default:
					searchString = @"";
					break;
			}
			
			googleString = [NSString stringWithFormat:@"http://news.google.com/news/search?aq=f&pz=1&cf=all&ned=us&hl=en&q=%@&btnmeta_news_search=Search+News", [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			[[self.exampleView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:googleString]]];
			
			break;
            
		case 4: // places
			googleString = [NSString stringWithFormat:@"http://news.google.com/news/search?aq=f&pz=1&cf=all&ned=us&hl=en&q=%@&btnmeta_news_search=Search+News", @"places"];
			[[self.exampleView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:googleString]]];
			
			break;
		case 5: // charts
			switch ( tabIndex ) {
				case 0:
					searchString = @"common charts";
					break;
				case 1:
					searchString = @"chart wizard";
					break;
				default:
					searchString = @"";
					break;
			}
			
			googleString = [NSString stringWithFormat:@"http://news.google.com/news/search?aq=f&pz=1&cf=all&ned=us&hl=en&q=%@&btnmeta_news_search=Search+News", [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			[[self.exampleView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:googleString]]];
			
			break;
            
		case 6: // reports
			switch ( tabIndex ) {
				case 0:
					searchString = @"common reports";
					break;
				case 1:
					searchString = @"saved reports";
					break;
				case 2:
					searchString = @"custom reports";
					break;
				default:
					searchString = @"";
					break;
			}
			
			googleString = [NSString stringWithFormat:@"http://news.google.com/news/search?aq=f&pz=1&cf=all&ned=us&hl=en&q=%@&btnmeta_news_search=Search+News", [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			[[self.exampleView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:googleString]]];
			
			break;
            
		case 7: // manage
			switch ( tabIndex ) {
				case 0:
					searchString = @"consistency";
					break;
				case 1:
					searchString = @"tasks";
					break;
				case 2:
					searchString = @"dna";
					break;
				default:
					searchString = @"";
            }
			
			googleString = [NSString stringWithFormat:@"http://news.google.com/news/search?aq=f&pz=1&cf=all&ned=us&hl=en&q=%@&btnmeta_news_search=Search+News", [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
			[[self.exampleView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:googleString]]];
			
			break;
            
		default:
			break;
	}
}

#pragma mark -
#pragma mark Matrix Actions

// demonstrating how to set the grouped tab view selection programmatically
// The matrix is visible via the View > Show Panel menu

- (IBAction) showPanel:(id)sender {
	if ( [self.panel isVisible] ) [self.panel orderOut:self];
	else [self.panel makeKeyAndOrderFront:self];
}

- (IBAction) setSelectedGroup:(id)sender {
	
	NSInteger selection = [sender selectedColumn];
	[self.groupedTabView setSelectedGroupIndexes:[NSIndexSet indexSetWithIndex:selection]];
}

- (IBAction) setSelectedTab:(id)sender {
	
	NSInteger selection = [sender selectedColumn];
	[self.groupedTabView setSelectedTabIndexes:[NSIndexSet indexSetWithIndex:selection]];
}

@end
